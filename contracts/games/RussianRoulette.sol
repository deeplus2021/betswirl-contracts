// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {PvPGame} from "./PvPGame.sol";
import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// import "hardhat/console.sol";
contract RussianRoulette is PvPGame {
    /// @notice Stores the Russian Roulette params
    struct RussianRouletteBet {
        uint16 maxSeats;
        uint32 startsAt;
        uint8 deathRatio;
        uint256 randomWord;
    }

    /// @notice Maps bets id with Russian Roulette data
    mapping(uint24 => RussianRouletteBet) private russianRouletteBets;

    /// @notice Maximum number of seats per game.
    uint16 public maxSeats;

    /// @notice Emitted after the max seats is set.
    event SetMaxSeats(uint16 maxSeats);

    // / @notice Emitted after a bet is placed.
    // / @param id The bet ID.
    // / @param player Address of the gamer.
    // / @param opponents Address of the opponents.
    // / @param token Address of the token.
    // / @param amount The bet amount.
    // / @param maxSeats Maximum of seats allowed.
    // / @param startsAt When the game can start even if not all seats has been filled.
    // / @param deathRatio Percentage of seats to kill.
    // / @param pot The prize pool.
    event PlaceBet(
        uint24 id,
        address indexed player,
        address[] opponents,
        address indexed token,
        uint256 amount,
        uint16 maxSeats,
        uint32 startsAt,
        uint8 deathRatio,
        uint256 pot
    );

    /// @notice Emitted after a bet is rolled.
    /// @param id The bet ID.
    /// @param seats Players addresses of seats.
    /// @param winners who won.
    /// @param killedSeats the bets won.
    /// @param token The token used.
    /// @param betAmount The bet amount.
    /// @param payout The payout amount.
    event Roll(
        uint24 indexed id,
        address[] seats,
        address[] winners,
        address[] killedSeats,
        address indexed token,
        uint256 betAmount,
        uint256 payout
    );

    /// @notice Emitted when chainlink's resolution appens
    /// @param id The bet ID.
    /// @param killedSeatsNumber Killed seats.
    event GameResolved(uint24 indexed id, uint256 killedSeatsNumber);

    error InvalidDeathRatio();
    error InvalidDate();

    constructor(
        address chainlinkCoordinatorAddress,
        address pvpGamesStoreAddress
    ) PvPGame(chainlinkCoordinatorAddress, pvpGamesStoreAddress) {}

    function setMaxSeats(uint16 _maxSeats) external onlyOwner {
        maxSeats = _maxSeats;
        emit SetMaxSeats(_maxSeats);
    }

    /// @notice Creates a new bet and stores the chosen coin face.
    /// @param token Address of the token.
    /// @param tokenAmount The number of tokens bet.
    /// @param opponents Selected players to play with.
    /// @param _maxSeats Maximum number of seats. The game will start when its reached.
    /// @param startsAt Timestamp when the game can start.
    /// @param deathRatio Players kill rate.
    function wager(
        address token,
        uint256 tokenAmount,
        address[] calldata opponents,
        uint16 _maxSeats,
        uint32 startsAt,
        uint8 deathRatio,
        bytes calldata nfts
    ) external payable whenNotPaused {
        if (_maxSeats < 2 || _maxSeats > maxSeats) revert WrongSeatsNumber();
        if (deathRatio == 0 || deathRatio > 99) revert InvalidDeathRatio();
        if (startsAt < block.timestamp) revert InvalidDate();

        Bet memory bet = _newBet(token, tokenAmount, opponents, nfts);
        russianRouletteBets[bet.id].maxSeats = _maxSeats;
        russianRouletteBets[bet.id].startsAt = startsAt;
        russianRouletteBets[bet.id].deathRatio = deathRatio;

        emit PlaceBet(
            bet.id,
            msg.sender,
            opponents,
            token,
            bet.amount,
            _maxSeats,
            startsAt,
            deathRatio,
            bet.pot
        );
    }

    function joinGame(uint24 id, uint16 seatsNumber) external payable {
        _joinGame(id, seatsNumber);
    }

    /// @notice Fullfills the chainlink request
    /// @param requestId id of the bet
    /// @param randomWords result
    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {
        uint24 id = _betsByVrfRequestId[requestId];
        Bet storage bet = bets[id];

        // Check the bet state in case it has been refunded or canceled
        if (bet.resolved) {
            revert NotPendingBet();
        }

        uint256 killedSeatsNumber = (bet.seats.length *
            russianRouletteBets[bet.id].deathRatio) / 100;
        if (killedSeatsNumber == 0) killedSeatsNumber = 1;

        russianRouletteBets[bet.id].randomWord = randomWords[0];

        emit GameResolved(id, killedSeatsNumber);
    }

    /// @notice Pull the triggers killing seats.
    /// @param id id of the bet
    function pullTriggers(uint24 id) external {
        // Check if random result has arrived
        uint256 randomWord = russianRouletteBets[id].randomWord;
        if (randomWord == 0) revert NotPendingBet();

        Bet storage bet = bets[id];
        uint256 seatsLength = bet.seats.length;
        uint256 killedSeatsNumber = (seatsLength *
            russianRouletteBets[bet.id].deathRatio) / 100;
        if (killedSeatsNumber == 0) killedSeatsNumber = 1;

        // Copy the list of players' seats
        address[] memory killedSeats = new address[](killedSeatsNumber);
        address[] memory winners = bet.seats;

        // Kill the seats
        for (uint i = 0; i < killedSeatsNumber; i++) {
            // Pickup a new random index
            uint256 deadIndex = uint256(keccak256(abi.encode(randomWord, i))) %
                (seatsLength - i);
            killedSeats[i] = winners[deadIndex];
            winners[deadIndex] = winners[seatsLength - i - 1];
            delete winners[seatsLength - i - 1];
        }

        uint256 remainingSeats = seatsLength - killedSeatsNumber;
        assembly {
            mstore(winners, remainingSeats)
        }

        uint256 payOut = _resolveBet(bet, winners, randomWord);

        emit Roll(
            id,
            bet.seats,
            winners,
            killedSeats,
            bet.token,
            bet.amount,
            payOut
        );
    }

    function betMaxSeats(uint24 id) public view override returns (uint256) {
        return russianRouletteBets[id].maxSeats;
    }

    function betMinSeats(uint24) public pure override returns (uint256) {
        return 2;
    }

    function gameCanStart(uint24 id) public view override returns (bool) {
        return russianRouletteBets[id].startsAt <= block.timestamp;
    }

    function getRussianRouletteBet(
        uint24 id
    )
        external
        view
        returns (RussianRouletteBet memory russianRouletteBet, Bet memory bet)
    {
        return (russianRouletteBets[id], bets[id]);
    }
}