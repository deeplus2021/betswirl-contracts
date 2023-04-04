// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {IPvPGamesStore} from "./IPvPGamesStore.sol";

contract PvPGamesStore is Ownable, IPvPGamesStore {

    /// @notice Maps tokens addresses to token configuration.
    mapping(address => Token) public tokens;

    /// @notice Number of tokens added.
    uint256 private _tokensCount;

    /// @notice Maps tokens indexes to token address.
    mapping(uint256 => address) private _tokensList;

    address public immutable treasuryWallet;
    address public teamWallet;
    event SetTeamWallet(address teamWallet);

    /// @notice Emitted after the Chainlink callback subId is set for a token.
    /// @param token Address of the token.
    /// @param vrfSubId New vrfSubId.
    event SetVRFSubId(
        address indexed token,
        uint64 vrfSubId
    );

    /// @notice Emitted after the token's house edge allocations for bet payout is set.
    /// @param token Address of the token.
    /// @param dividend Rate to be allocated as staking rewards, on bet payout.
    /// @param treasury Rate to be allocated to the treasury, on bet payout.
    /// @param team Rate to be allocated to the team, on bet payout.
    event SetTokenHouseEdgeSplit(
        address indexed token,
        uint16 dividend,
        uint16 treasury,
        uint16 team,
        uint16 initiator
    );

    /// @notice Emitted after a token is added.
    /// @param token Address of the token.
    event AddToken(address token);

    /// @notice Emitted after a token is paused.
    /// @param token Address of the token.
    /// @param paused Whether the token is paused for betting.
    event SetPausedToken(address indexed token, bool paused);

    /// @notice Reverting error when trying to add an existing token.
    error TokenExists();

    /// @notice Reverting error when setting the house edge allocations, but the sum isn't 100%.
    /// @param sum of the house edge allocations rates.
    error WrongHouseEdgeSplit(uint256 sum);

    /// @notice Reverting error when provided address isn't valid.
    error InvalidAddress();

    /// @param treasuryWalletAddress Treasury multi-sig wallet.
    /// @param teamWalletAddress Team wallet.
    constructor (address treasuryWalletAddress,
        address teamWalletAddress
    ) {
        if (
            treasuryWalletAddress == address(0)
        ) {
            revert InvalidAddress();
        }
        treasuryWallet = treasuryWalletAddress;
        setTeamWallet(teamWalletAddress);
    }

    /// @notice Sets the token's house edge allocations for bet payout.
    /// @param token Address of the token.
    /// @param dividend Rate to be allocated as staking rewards, on bet payout.
    /// @param treasury Rate to be allocated to the treasuryWallet, on bet payout.
    /// @param team Rate to be allocated to the team, on bet payout.
    /// @param initiator Rate to be allocated to the initiator of the bet, on bet payout.
    /// @dev `dividend`, `_treasuryWallet` and `team` rates sum must equals 10000.
    function setHouseEdgeSplit(
        address token,
        uint16 dividend,
        uint16 treasury,
        uint16 team,
        uint16 initiator
    ) external onlyOwner {
        uint16 splitSum = dividend + team + treasury + initiator;
        if (splitSum != 10000) {
            revert WrongHouseEdgeSplit(splitSum);
        }

        HouseEdgeSplit storage tokenHouseEdge = tokens[token].houseEdgeSplit;
        tokenHouseEdge.dividend = dividend;
        tokenHouseEdge.treasury = treasury;
        tokenHouseEdge.team = team;
        tokenHouseEdge.initiator = initiator;

        emit SetTokenHouseEdgeSplit(
            token,
            dividend,
            treasury,
            team,
            initiator
        );
    }

    /// @notice Adds a new token that'll be enabled for the games' betting.
    /// Token shouldn't exist yet.
    /// @param token Address of the token.
    function addToken(address token) external onlyOwner {
        if (_tokensCount != 0) {
            for (uint8 i; i < _tokensCount; i++) {
                if (_tokensList[i] == token) {
                    revert TokenExists();
                }
            }
        }
        _tokensList[_tokensCount] = token;
        _tokensCount += 1;
        emit AddToken(token);
    }

    /// @notice Sets the Chainlink VRF subId.
    /// @param vrfSubId New subId.
    function setVRFSubId(address token, uint64 vrfSubId)
        public
        onlyOwner
    {
        tokens[token].vrfSubId = vrfSubId;
        emit SetVRFSubId(token, vrfSubId);
    }

    /// @notice Sets the new team wallet.
    /// @param _teamWallet The team wallet address.
    function setTeamWallet(address _teamWallet)
        public
        onlyOwner()
    {
        if (_teamWallet == address(0)) {
            revert InvalidAddress();
        }
        teamWallet = _teamWallet;
        emit SetTeamWallet(teamWallet);
    }

    /// @dev For the front-end
    function getTokens() external view returns (TokenMetadata[] memory) {
        TokenMetadata[] memory _tokens = new TokenMetadata[](_tokensCount);
        for (uint8 i; i < _tokensCount; i++) {
            address tokenAddress = _tokensList[i];
            Token memory token = tokens[tokenAddress];
            if (tokenAddress == address(0)) {
                _tokens[i] = TokenMetadata({
                    decimals: 18,
                    tokenAddress: tokenAddress,
                    name: "ETH",
                    symbol: "ETH",
                    token: token
                });
            } else {
                IERC20Metadata erc20Metadata = IERC20Metadata(tokenAddress);
                _tokens[i] = TokenMetadata({
                    decimals: erc20Metadata.decimals(),
                    tokenAddress: tokenAddress,
                    name: erc20Metadata.name(),
                    symbol: erc20Metadata.symbol(),
                    token: token
                });
            }
        }
        return _tokens;
    }

    function getTokensAddresses() external view returns (address[] memory) {
        address[] memory _tokens = new address[](_tokensCount);
        for (uint8 i; i < _tokensCount; i++) {
            _tokens[i] = _tokensList[i];
        }
        return _tokens;
    }

    function getTokenConfig(address token) public view returns (Token memory config) {
      config = tokens[token];
    }

    function getTreasuryAndTeamAddresses() public view returns (address, address) {
        return (treasuryWallet, teamWallet);
    }
}