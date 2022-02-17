// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import {Game} from "./Game.sol";

/// @title BetSwirl's Coin Toss game
/// @notice The game is played with a two-sided coin. The game's goal is to guess whether the lucky coin face will be Heads or Tails.
/// @author Romuald Hog (based on Yakitori's Coin Toss)
contract CoinToss is Game {
    /// @notice Coin Toss bet information struct.
    /// @param bet The Bet struct information.
    /// @param face The chosen coin face.
    /// @dev Used to package bet information for the front-end.
    struct CoinTossBet {
        Bet bet;
        bool face;
    }

    /// @notice Maps bets IDs to chosen coin face.
    /// @dev Coin faces: true = Tails, false = Heads.
    mapping(uint256 => bool) public coinTossBets;

    /// @notice Emitted after a bet is placed.
    /// @param id The bet ID.
    /// @param user Address of the gamer.
    /// @param token Address of the token.
    /// @param face The chosen coin face.
    event PlaceBet(
        uint256 id,
        address indexed user,
        address indexed token,
        bool face
    );

    /// @notice Emitted after a bet is rolled.
    /// @param id The bet ID.
    /// @param user Address of the gamer.
    /// @param token Address of the token.
    /// @param amount The bet amount.
    /// @param face The chosen coin face.
    /// @param rolled The rolled coin face.
    /// @param payout The payout amount.
    event Roll(
        uint256 id,
        address indexed user,
        address indexed token,
        uint256 amount,
        bool face,
        bool rolled,
        uint256 payout
    );

    /// @notice Initialize the game base contract.
    /// @param bankAddress The address of the bank.
    /// @param chainlinkCoordinatorAddress Address of the Chainlink VRF Coordinator.
    /// @param numRandomWords How many random words is needed to resolve a game's bet.
    constructor(
        address bankAddress,
        address referralProgramAddress,
        address chainlinkCoordinatorAddress,
        uint16 numRandomWords
    ) Game(bankAddress, referralProgramAddress, chainlinkCoordinatorAddress, numRandomWords) {}

    /// @notice Sets the game house edge rate for a specific token.
    /// @param token Address of the token.
    /// @param _houseEdge House edge rate.
    function setHouseEdge(address token, uint16 _houseEdge) external onlyOwner {
        _setHouseEdge(token, _houseEdge);
    }

    /// @notice Creates a new bet and stores the chosen coin face.
    /// @param face The chosen coin face.
    /// @param token Address of the token.
    /// @param tokenAmount The number of tokens bet.
    /// @param referrer Address of the referrer.
    function wager(
        bool face,
        address token,
        uint256 tokenAmount,
        address referrer
    ) external payable whenNotPaused {
        Bet memory bet = _newBet(
            token,
            tokenAmount,
            getPayout(10000),
            referrer
        );

        coinTossBets[bet.id] = face;

        emit PlaceBet(bet.id, bet.user, bet.token, face);
    }

    /// @notice Resolves the bet using the Chainlink randomness.
    /// @param id The bet ID.
    /// @param randomWords Random words list. Contains only one for this game.
    // solhint-disable-next-line private-vars-leading-underscore
    function fulfillRandomWords(uint256 id, uint256[] memory randomWords)
        internal
        override
    {
        bool face = coinTossBets[id];
        Bet storage bet = bets[id];

        uint256 rolled = randomWords[0] % 2;

        bool[2] memory coinSides = [false, true];
        bool rolledCoinSide = coinSides[rolled];
        uint256 payout = _resolveBet(
            bet,
            rolledCoinSide == face,
            getPayout(bet.amount)
        );

        emit Roll(
            bet.id,
            bet.user,
            bet.token,
            bet.amount,
            face,
            rolledCoinSide,
            payout
        );
    }

    /// @notice Gets the list of a user unresolved bets.
    /// @param user Address of the gamer.
    /// @param dataLength The amount of unresolved bets to return.
    /// @return A list of Coin Toss bet.
    function getLastUserUnresolvedBets(address user, uint256 dataLength)
        external
        view
        returns (CoinTossBet[] memory)
    {
        Bet[] memory unresolvedBets = _getLastUserUnresolvedBets(
            user,
            dataLength
        );
        CoinTossBet[] memory unresolvedCoinTossBets = new CoinTossBet[](
            unresolvedBets.length
        );
        for (uint256 i; i < unresolvedBets.length; i++) {
            unresolvedCoinTossBets[i] = CoinTossBet(
                unresolvedBets[i],
                coinTossBets[unresolvedBets[i].id]
            );
        }
        return unresolvedCoinTossBets;
    }

    /// @notice Calculates the target payout amount.
    /// @param betAmount Bet amount.
    /// @return The target payout amount.
    function getPayout(uint256 betAmount) public pure returns (uint256) {
        return betAmount * 2;
    }
}
