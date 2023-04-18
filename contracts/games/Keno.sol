// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {Game} from "./Game.sol";

/// @title BetSwirl's Keno game
/// @notice

contract Keno is Game {
    /// @notice Full keno bet information struct.
    /// @param bet The Bet struct information.
    /// @param kenoBet The Keno bet struct information.
    /// @dev Used to package bet information for the front-end.
    struct FullKenoBet {
        Bet bet;
        KenoBet kenoBet;
    }

    /// @notice Keno bet information struct.
    /// @param bet The Bet struct information.
    /// @param numbers The chosen numbers.
    struct KenoBet {
        uint40 numbers;
        uint40 rolled;
    }

    /// @notice stores the settings for a specific token
    /// @param biggestNumber Sets the biggest number that can be played
    /// @param maxNumbersPlayed Sets the maximum numbers that can be picked
    struct TokenConfig {
        uint128 biggestNumber;
        uint128 maxNumbersPlayed;
    }

    /// @notice Maps bets IDs to chosen numbers.
    mapping(uint256 => KenoBet) public kenoBets;

    /// @notice Maps all possible factors.
    mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256[])))
        private gainsFactor;

    /// @notice Maps all token configs
    mapping(address => TokenConfig) public tokenConfigurations;

    uint256 private constant FACTORPRECISION = 10000;

    /// @notice Emitted after a bet is placed.
    /// @param id The bet ID.
    /// @param user Address of the gamer.
    /// @param token Address of the token.
    /// @param amount The bet amount.
    /// @param vrfCost The Chainlink VRF cost paid by player.
    /// @param numbers The chosen numbers.
    event PlaceBet(
        uint256 id,
        address indexed user,
        address indexed token,
        uint256 amount,
        uint256 vrfCost,
        uint40 numbers
    );

    /// @notice Emitted after a bet is rolled.
    /// @param id The bet ID.
    /// @param user Address of the gamer.
    /// @param token Address of the token.
    /// @param amount The bet amount.
    /// @param numbers The chosen numbers.
    /// @param rolled The rolled number.
    /// @param payout The payout amount.
    event Roll(
        uint256 id,
        address indexed user,
        address indexed token,
        uint256 amount,
        uint40 numbers,
        uint40 rolled,
        uint256 payout
    );

    /// @notice Emitted when the settings are updated for a specific token
    /// @param newBiggestNumber The new biggest number
    /// @param newMaxNumbers The new maximum of pick
    event TokenConfigUpdated(
        address token,
        uint128 newBiggestNumber,
        uint128 newMaxNumbers
    );

    /// @notice Numbers provided is not in the allowed range
    error NumbersNotInRange();

    /// @notice Too many numbers are submitted.
    error TooManyNumbersPlayed();

    /// @notice Thrown when settings could block the contract.
    error InvalidSettings();

    /// @notice Initialize the game base contract.
    /// @param bankAddress The address of the bank.
    /// @param chainlinkCoordinatorAddress Address of the Chainlink VRF Coordinator.
    /// @param LINK_ETH_feedAddress Address of the Chainlink LINK/ETH price feed.
    constructor(
        address bankAddress,
        address chainlinkCoordinatorAddress,
        address LINK_ETH_feedAddress,
        address wrappedGasToken
    ) Game(bankAddress, chainlinkCoordinatorAddress, 1, LINK_ETH_feedAddress) {}

    /// @notice Calculate all gain factors
    /// @param token used
    function _calculateFactors(address token) private {
        TokenConfig memory config = tokenConfigurations[token];
        for (uint256 played = 1; played <= config.maxNumbersPlayed; played++) {
            uint256[] storage factors = gainsFactor[config.biggestNumber][
                config.maxNumbersPlayed
            ][played];
            if (factors.length == 0) {
                for (
                    uint256 matchCount = 0;
                    matchCount <= played;
                    matchCount++
                ) {
                    factors.push(gain(token, played, matchCount));
                }
            }
        }
    }

    /// @notice Updates the settings for a specific token
    /// @param newBiggestNumber The new biggest number
    /// @param newMaxNumbers The new maximum of pick
    function updateTokenConfig(
        address token,
        uint128 newBiggestNumber,
        uint128 newMaxNumbers
    ) external onlyOwner {
        if (hasPendingBets(token)) {
            revert TokenHasPendingBets();
        }
        if (
            newMaxNumbers > newBiggestNumber ||
            newBiggestNumber > 40 ||
            newMaxNumbers > 10
        ) revert InvalidSettings();

        TokenConfig storage config = tokenConfigurations[token];
        config.biggestNumber = newBiggestNumber;
        config.maxNumbersPlayed = newMaxNumbers;

        _calculateFactors(token);
        emit TokenConfigUpdated(token, newBiggestNumber, newMaxNumbers);
    }

    /// @notice Calculates the target payout amount.
    /// @param betAmount Bet amount.
    /// @param played the count of numbers played
    /// @param matchCount the count of matching numbers
    /// @return factor The target payout amount.
    function _getPayout(
        address token,
        uint256 betAmount,
        uint256 played,
        uint256 matchCount
    ) private view returns (uint256 factor) {
        TokenConfig memory config = tokenConfigurations[token];
        factor =
            (betAmount *
                gainsFactor[config.biggestNumber][config.maxNumbersPlayed][
                    played
                ][matchCount]) /
            FACTORPRECISION;
    }

    /// @notice Creates a new bet and stores the chosen bet mask.
    /// @param numbers The chosen numbers.
    /// @param token Address of the token.
    /// @param tokenAmount The number of tokens bet.
    function wager(
        uint40 numbers,
        address token,
        uint256 tokenAmount
    ) external payable whenNotPaused {
        TokenConfig memory config = tokenConfigurations[token];
        if (numbers == 0 || numbers >= 2 ** config.biggestNumber - 1) {
            revert NumbersNotInRange();
        }

        uint256 _count = _countNumbers(numbers);
        if (_count > config.maxNumbersPlayed) {
            revert TooManyNumbersPlayed();
        }

        Bet memory bet = _newBet(
            token,
            tokenAmount,
            _getPayout(token, 10000, _count, _count)
        );

        kenoBets[bet.id].numbers = numbers;

        emit PlaceBet(
            bet.id,
            bet.user,
            bet.token,
            bet.amount,
            bet.vrfCost,
            numbers
        );
    }

    /// @notice Count how many numbers are encoded
    /// @param numbers The binary encoded list of numbers
    /// @return count The total of numbers encoded
    function _countNumbers(
        uint40 numbers
    ) private pure returns (uint256 count) {
        if (numbers & 0x1 > 0) count++;
        if (numbers & 0x2 > 0) count++;
        if (numbers & 0x4 > 0) count++;
        if (numbers & 0x8 > 0) count++;

        if (numbers & 0x10 > 0) count++;
        if (numbers & 0x20 > 0) count++;
        if (numbers & 0x40 > 0) count++;
        if (numbers & 0x80 > 0) count++;

        if (numbers & 0x100 > 0) count++;
        if (numbers & 0x200 > 0) count++;
        if (numbers & 0x400 > 0) count++;
        if (numbers & 0x800 > 0) count++;

        if (numbers & 0x1000 > 0) count++;
        if (numbers & 0x2000 > 0) count++;
        if (numbers & 0x4000 > 0) count++;
        if (numbers & 0x8000 > 0) count++;

        if (numbers & 0x10000 > 0) count++;
        if (numbers & 0x20000 > 0) count++;
        if (numbers & 0x40000 > 0) count++;
        if (numbers & 0x80000 > 0) count++;

        if (numbers & 0x100000 > 0) count++;
        if (numbers & 0x200000 > 0) count++;
        if (numbers & 0x400000 > 0) count++;
        if (numbers & 0x800000 > 0) count++;

        if (numbers & 0x1000000 > 0) count++;
        if (numbers & 0x2000000 > 0) count++;
        if (numbers & 0x4000000 > 0) count++;
        if (numbers & 0x8000000 > 0) count++;

        if (numbers & 0x10000000 > 0) count++;
        if (numbers & 0x20000000 > 0) count++;
        if (numbers & 0x40000000 > 0) count++;
        if (numbers & 0x80000000 > 0) count++;

        if (numbers & 0x100000000 > 0) count++;
        if (numbers & 0x200000000 > 0) count++;
        if (numbers & 0x400000000 > 0) count++;
        if (numbers & 0x800000000 > 0) count++;

        if (numbers & 0x1000000000 > 0) count++;
        if (numbers & 0x2000000000 > 0) count++;
        if (numbers & 0x4000000000 > 0) count++;
        if (numbers & 0x8000000000 > 0) count++;
    }

    /// @notice Resolves the bet using the Chainlink randomness.
    /// @param id The bet ID.
    /// @param randomWords Random words list. Contains only one for this game.
    // solhint-disable-next-line private-vars-leading-underscore
    function fulfillRandomWords(
        uint256 id,
        uint256[] memory randomWords
    ) internal override {
        uint256 startGas = gasleft();

        KenoBet storage kenoBet = kenoBets[id];
        Bet storage bet = bets[id];
        uint40 rolled = getNumbersOutOfRandomWord(bet.token, randomWords[0]);

        kenoBet.rolled = rolled;
        uint256 _gain = _getPayout(
            bet.token,
            bet.amount,
            _countNumbers(kenoBet.numbers),
            _countNumbers(kenoBet.numbers & rolled)
        );

        uint256 payout = _resolveBet(bet, _gain);

        emit Roll(
            bet.id,
            bet.user,
            bet.token,
            bet.amount,
            kenoBet.numbers,
            rolled,
            payout
        );

        _accountVRFCost(bet, startGas);
    }

    /// @notice Calculate the _factorial of a number
    /// @param n Param for the calculation
    /// @return result The _factorial result
    function _fact(uint256 n) private pure returns (uint256 result) {
        if (n == 0) return 1;
        result = n;
        for (uint i = n - 1; i > 1; i--) {
            result = result * i;
        }
    }

    /// @notice Calculate the proability to draw x items out of n
    /// @param n Total number
    /// @param x Number of Trials
    /// @return The mathematical result
    function _outof(uint n, uint x) private pure returns (uint256) {
        return _fact(n) / (_fact(x) * _fact(n - x));
    }

    /// @notice Calculate the gain ratio based on Hypergeometric formula
    /// @param played Number of numbers chosen
    /// @param matchCount Number of winning numbers
    /// @return _factor The gain _factor
    function gain(
        address token,
        uint256 played,
        uint256 matchCount
    ) public view returns (uint256 _factor) {
        TokenConfig memory config = tokenConfigurations[token];

        uint256 hypergeometricNumerator = _outof(played, matchCount) *
            _outof(
                config.biggestNumber - played,
                config.maxNumbersPlayed - matchCount
            );
        uint256 hypergeometricDenominator = _outof(
            config.biggestNumber,
            config.maxNumbersPlayed
        );

        // Calculate the inverse of the hypergeometric function
        _factor =
            (FACTORPRECISION * hypergeometricDenominator) /
            (hypergeometricNumerator * (played + 1));
    }

    /// @notice returns all gains table for one token
    /// @param token used
    function gains(
        address token
    )
        external
        view
        returns (
            uint biggestNumber,
            uint maxNumbersPlayed,
            uint256[] memory _gains
        )
    {
        TokenConfig memory config = tokenConfigurations[token];
        _gains = new uint256[](config.maxNumbersPlayed + 1);
        biggestNumber = config.biggestNumber;
        maxNumbersPlayed = config.maxNumbersPlayed;
        for (
            uint256 matchCount = 0;
            matchCount <= config.maxNumbersPlayed;
            matchCount++
        ) {
            _gains[matchCount] = gainsFactor[config.biggestNumber][
                config.maxNumbersPlayed
            ][config.maxNumbersPlayed][matchCount];
        }
    }

    /// @notice Transforms a random word into a suite of number encoded in binary
    /// @param randomWord The source of randomness
    /// @return result The encoded numbers list
    function getNumbersOutOfRandomWord(
        address token,
        uint256 randomWord
    ) public view returns (uint40) {
        uint256 result = 0;
        TokenConfig memory config = tokenConfigurations[token];
        for (uint256 i = 0; i < config.maxNumbersPlayed; i++) {
            // Draw a number
            uint256 current = ((randomWord & 0xFF) % config.biggestNumber) + 1;

            // Check if number does not already exist
            uint256 bitmask = 2 ** (current - 1);
            while ((result & bitmask) != 0) {
                // Draw the next number is it does already exist
                current += 1;

                // Loop back to the first number if biggest number is reached
                if (current > config.biggestNumber) current = 1;
                bitmask = 2 ** (current - 1);
            }

            // Add the number to the result
            result = result | bitmask;

            // Offset to draw the next one
            randomWord = randomWord >> 8;
        }
        return uint40(result);
    }

    /// @notice Gets the list of the last user bets.
    /// @param user Address of the gamer.
    /// @param dataLength The amount of bets to return.
    /// @return A list of Keno bet.
    function getLastUserBets(
        address user,
        uint256 dataLength
    ) external view returns (FullKenoBet[] memory) {
        Bet[] memory lastBets = _getLastUserBets(user, dataLength);
        FullKenoBet[] memory lastKenoBets = new FullKenoBet[](lastBets.length);
        for (uint256 i; i < lastBets.length; i++) {
            lastKenoBets[i] = FullKenoBet(
                lastBets[i],
                kenoBets[lastBets[i].id]
            );
        }
        return lastKenoBets;
    }
}
