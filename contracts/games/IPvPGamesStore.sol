// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IPvPGamesStore {

    /// @notice Token's house edge allocations struct.
    /// The games house edge is split into several allocations.
    /// The allocated amounts stays in the controct until authorized parties withdraw. They are subtracted from the balance.
    /// @param dividend Rate to be allocated as staking rewards, on bet payout.
    /// @param treasury Rate to be allocated to the treasury, on bet payout.
    /// @param team Rate to be allocated to the team, on bet payout.
    /// @param dividendAmount The number of tokens to be sent as staking rewards.
    /// @param treasuryAmount The number of tokens to be sent to the treasury.
    /// @param teamAmount The number of tokens to be sent to the team.
    struct HouseEdgeSplit {
        uint16 dividend;
        uint16 treasury;
        uint16 team;
        uint16 initiator;
    }

    /// @notice Token struct.
    /// @param houseEdge House edge rate.
    /// @param pendingCount Number of pending bets.
    /// @param VRFFees Chainlink's VRF collected fees amount.
    struct Token {
        uint64 vrfSubId;
        HouseEdgeSplit houseEdgeSplit;
    }

    /// @notice Token's metadata struct. It contains additional information from the ERC20 token.
    /// @dev Only used on the `getTokens` getter for the front-end.
    /// @param decimals Number of token's decimals.
    /// @param tokenAddress Contract address of the token.
    /// @param name Name of the token.
    /// @param symbol Symbol of the token.
    /// @param token Token data.
    struct TokenMetadata {
        uint8 decimals;
        address tokenAddress;
        string name;
        string symbol;
        Token token;
    }

  function setHouseEdgeSplit(
        address token,
        uint16 dividend,
        uint16 treasury,
        uint16 team,
        uint16 initiator
    ) external;

  function addToken(address token) external;
  function setVRFSubId(address token, uint64 vrfSubId) external;
  function setTeamWallet(address teamWallet) external;
  function getTokenConfig(address token) external view returns (Token memory config);
  function getTreasuryAndTeamAddresses() external view returns (address, address);
  function getTokensAddresses() external view returns (address[] memory);
}