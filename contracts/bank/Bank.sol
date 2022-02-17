// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import {IReferral} from "./Referral.sol";

// import "hardhat/console.sol";

/// @title BetSwirl's Bank
/// @author Romuald Hog
/// @notice The Bank contract holds the casino's funds,
/// whitelist the games betting tokens,
/// define the max bet amount based on a risk,
/// payout the bet profit to user and collect the loss bet amount from the game's contract,
/// split and allocate the house edge taken from each bet (won or loss),
/// manage the tokens balance overflow to dynamically send overflowed tokens to the treasury and team.
/// The admin role is transfered to a Timelock that execute administrative tasks,
/// only the Games could payout the bet profit from the bank, and send the loss bet amount to the bank.
/// @dev All rates are in basis point.
contract Bank is AccessControl {
    using SafeERC20 for IERC20;

    /// @notice Token's house edge allocations struct.
    /// The games house edge is split into several allocations, that are different if the bet is won (payout) or loss (cash-in).
    /// The allocated amounts stays in the bank until authorized parties withdraw. They are subtracted from the balance.
    /// @param dividend Rate to be allocated as staking rewards, on bet payout.
    /// @param referral Rate to be allocated to the referrers, on bet payout.
    /// @param treasury Rate to be allocated to the treasury, on bet payout.
    /// @param team Rate to be allocated to the team, on bet payout.
    /// @param cashInDividend Rate to be allocated as staking rewards, on bet cash in.
    /// @param cashInReferral Rate to be allocated to the referrers, on bet cash in.
    /// @param cashInTreasury Rate to be allocated to the treasury, on bet cash in.
    /// @param cashInTeam Rate to be allocated to the team, on bet cash in.
    /// @param dividendAmount The number of tokens to be sent as staking rewards.
    /// @param treasuryAmount The number of tokens to be sent to the treasury.
    /// @param teamAmount The number of tokens to be sent to the team.
    struct HouseEdgeSplit {
        uint16 dividend;
        uint16 referral;
        uint16 treasury;
        uint16 team;
        uint16 cashInDividend;
        uint16 cashInReferral;
        uint16 cashInTreasury;
        uint16 cashInTeam;
        uint256 dividendAmount;
        uint256 treasuryAmount;
        uint256 teamAmount;
    }

    /// @notice Token's balance overflow struct.
    /// When the bank overflow threshold amount is reached on a token balance,
    /// the bank sends a percentage to the treasury and team, and the new token's balance reference is set.
    /// @param thresholdRate Threshold rate for the token's balance reference.
    /// @param toTreasury Rate to be allocated to the treasury.
    /// @param toTeam Rate to be allocated to the team.
    struct BalanceOverflow {
        uint16 thresholdRate;
        uint16 toTreasury;
        uint16 toTeam;
    }

    /// @notice Token struct.
    /// List of tokens to bet on games.
    /// @param allowed Whether the token is allowed for bets.
    /// @param houseEdgeSplit House edge allocations.
    /// @param balanceReference Balance reference used to manage the bank overflow.
    /// @param balanceOverflow Balance overflow management configuration.
    struct Token {
        bool allowed;
        HouseEdgeSplit houseEdgeSplit;
        uint256 balanceReference;
        BalanceOverflow balanceOverflow;
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

    /// @notice Defines the maximum bank payout, used to calculate the max bet amount.
    uint16 public balanceRisk = 200;

    /// @notice Number of tokens added.
    uint16 private _tokensCount;

    /// @notice Treasury multi-sig wallet.
    address payable public immutable treasury;

    /// @notice Team wallet.
    address payable public teamWallet;

    /// @notice Referral program contract.
    IReferral public referralProgram;

    /// @notice Role associated to Games smart contracts.
    bytes32 public constant GAME_ROLE = keccak256("GAME_ROLE");

    /// @notice Maps tokens addresses to token configuration.
    mapping(address => Token) private _tokens;

    /// @notice Maps tokens indexes to token address.
    mapping(uint16 => address) private _tokensList;

    /// @notice Emitted after the team wallet is set.
    /// @param teamWallet The team wallet address.
    event SetTeamWallet(address teamWallet);

    /// @notice Emitted after the referral program is set.
    /// @param referralProgram The referral program address.
    event SetReferralProgram(address referralProgram);

    /// @notice Emitted after the balance risk is set.
    /// @param balanceRisk Rate defining the balance risk.
    event SetBalanceRisk(uint16 balanceRisk);

    /// @notice Emitted after a token is added.
    /// @param token Address of the token.
    event AddToken(address token);

    /// @notice Emitted after a token is allowed.
    /// @param token Address of the token.
    /// @param allowed Whether the token is allowed for betting.
    event SetAllowedToken(address indexed token, bool allowed);

    /// @notice Emitted after a token deposit.
    /// @param token Address of the token.
    /// @param amount The number of token deposited.
    event Deposit(address indexed token, uint256 amount);

    /// @notice Emitted after a token withdrawal.
    /// @param token Address of the token.
    /// @param amount The number of token withdrawn.
    event Withdraw(address indexed token, uint256 amount);

    /// @notice Emitted after the token's house edge allocations for bet payout is set.
    /// @param token Address of the token.
    /// @param dividend Rate to be allocated as staking rewards, on bet payout.
    /// @param referral Rate to be allocated to the referrers, on bet payout.
    /// @param treasury Rate to be allocated to the treasury, on bet payout.
    /// @param team Rate to be allocated to the team, on bet payout.
    event SetTokenHouseEdgeSplit(
        address indexed token,
        uint16 dividend,
        uint16 referral,
        uint16 treasury,
        uint16 team
    );

    /// @notice Emitted after the token's house edge allocations for bet amount cash-in is set.
    /// @param token Address of the token.
    /// @param cashInDividend Rate to be allocated as staking rewards, on bet cash in.
    /// @param cashInReferral Rate to be allocated to the referrers, on bet cash in.
    /// @param cashInTreasury Rate to be allocated to the treasury, on bet cash in.
    /// @param cashInTeam Rate to be allocated to the team, on bet cash in.
    event SetCashInTokenHouseEdgeSplit(
        address indexed token,
        uint16 cashInDividend,
        uint16 cashInReferral,
        uint16 cashInTreasury,
        uint16 cashInTeam
    );

    /// @notice Emitted after the token's treasury and team allocations are distributed.
    /// @param token Address of the token.
    /// @param treasuryAmount The number of tokens sent to the treasury.
    /// @param teamAmount The number of tokens sent to the team.
    event HouseEdgeDistribution(
        address indexed token,
        uint256 treasuryAmount,
        uint256 teamAmount
    );

    /// @notice Emitted after the token's balance overflow management configuration is set.
    /// @param token Address of the token.
    /// @param thresholdRate Threshold rate for the token's balance reference.
    /// @param toTreasury Rate to be allocated to the treasury.
    /// @param toTeam Rate to be allocated to the team.
    event SetBalanceOverflow(
        address indexed token,
        uint16 thresholdRate,
        uint16 toTreasury,
        uint16 toTeam
    );

    /// @notice Emitted after the token's bank overflow amount is distributed to the treasury and team.
    /// @param token Address of the token.
    /// @param amountToTreasury The number of tokens sent to the treasury.
    /// @param amountToTeam The number of tokens sent to the team.
    event BankOverflowTransfer(
        address indexed token,
        uint256 amountToTreasury,
        uint256 amountToTeam
    );

    /// @notice Emitted after the token's balance reference is set.
    /// This happends on deposit, withdraw and when the bank overflow threashold is reached.
    /// @param token Address of the token.
    /// @param balanceReference New balance reference used to determine the bank overflow.
    event SetBalanceReference(address indexed token, uint256 balanceReference);

    /// @notice Emitted after the token's house edge is allocated.
    /// @param token Address of the token.
    /// @param dividend The number of tokens allocated as staking rewards.
    /// @param referral The number of tokens allocated to the referrers.
    /// @param treasury The number of tokens allocated to the treasury.
    /// @param team The number of tokens allocated to the team.
    event AllocateHouseEdgeAmount(
        address indexed token,
        uint256 dividend,
        uint256 referral,
        uint256 treasury,
        uint256 team
    );

    /// @notice Emitted after the bet profit amount is sent to the user.
    /// @param token Address of the token.
    /// @param newBalance New token balance.
    /// @param profit Bet profit amount sent.
    event Payout(address indexed token, uint256 newBalance, uint256 profit);

    /// @notice Emitted after the bet amount is collected from the game smart contract.
    /// @param token Address of the token.
    /// @param newBalance New token balance.
    /// @param amount Bet amount collected.
    event CashIn(address indexed token, uint256 newBalance, uint256 amount);

    /// @notice Reverting error when trying to add an existing token.
    /// @param token Address of the token.
    error TokenExists(address token);
    /// @notice Reverting error when setting the house edge allocations, but the sum isn't 100%.
    /// @param splitSum Sum of the house edge allocations rates.
    error WrongHouseEdgeSplit(uint16 splitSum);
    /// @notice Reverting error when setting wrong balance overflow management configuration.
    error WrongBalanceOverflow();

    /// @notice Initialize the contract's admin role to the deployer, and state variables.
    /// @param treasuryAddress Treasury multi-sig wallet.
    /// @param teamWalletAddress Team wallet.
    constructor(
        address payable treasuryAddress,
        address payable teamWalletAddress,
        IReferral referralProgramAddress
    ) {
        // The ownership should then be transfered to the Timelock.
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

        treasury = treasuryAddress;
        setTeamWallet(teamWalletAddress);
        setReferralProgram(referralProgramAddress);
    }

    /// @notice Transfers a specific amount of token to an address.
    /// Uses native transfer or ERC20 transfer depending on the token.
    /// @dev The 0x address is considered the gas token.
    /// @param user Address of destination.
    /// @param token Address of the token.
    /// @param amount Number of tokens.
    function _safeTransfer(
        address payable user,
        address token,
        uint256 amount
    ) private {
        if (_isGasToken(token)) {
            user.transfer(amount);
        } else {
            IERC20(token).safeTransfer(user, amount);
        }
    }

    /// @notice Splits the house edge fees and allocates them as dividends, for referrers, to the treasury and team.
    /// If the user has no referrer, the referral allocation is allocated evenly among the other allocations.
    /// @param user Address of the gamer.
    /// @param token Address of the token.
    /// @param fees Bet amount or bet profit fees.
    /// @param tokenHouseEdge To update the house edge allocations amounts.
    /// @param dividend Rate to be allocated as staking rewards.
    /// @param referral Rate to be allocated to the referrers.
    /// @param _treasury Rate to be allocated to the treasury.
    /// @param team Rate to be allocated to the team.
    function _allocateHouseEdge(
        address user,
        address token,
        uint256 fees,
        HouseEdgeSplit storage tokenHouseEdge,
        uint16 dividend,
        uint16 referral,
        uint16 _treasury,
        uint16 team
    ) private {
        uint256 referralAllocation = (fees * referral) / 10000;
        uint256 referralAmount;
        if (referralAllocation != 0 && address(referralProgram) != address(0)) {
            referralAmount = referralProgram.payReferral(
                user,
                token,
                referralAllocation
            );
            referralAllocation -= referralAmount;
        }

        uint256 referralAllocationRestPerSplit = (referralAllocation -
            (referralAllocation % 3)) / 3;
        uint256 dividendAmount = ((fees * dividend) / 10000) +
            referralAllocationRestPerSplit;
        uint256 treasuryAmount = ((fees * _treasury) / 10000) +
            referralAllocationRestPerSplit;
        uint256 teamAmount = ((fees * team) / 10000) +
            referralAllocationRestPerSplit;

        tokenHouseEdge.dividendAmount += dividendAmount;
        tokenHouseEdge.treasuryAmount += treasuryAmount;
        tokenHouseEdge.teamAmount += teamAmount;

        emit AllocateHouseEdgeAmount(
            token,
            dividendAmount,
            referralAmount,
            treasuryAmount,
            teamAmount
        );

        if (referralAmount != 0) {
            _safeTransfer(
                payable(address(referralProgram)),
                token,
                referralAmount
            );
        }
    }

    /// @notice Sets the new token's balance reference.
    /// @param token Address of the token.
    /// @param newReference Balance amount corresponding to the new reference.
    function _setBalanceReference(address token, uint256 newReference) private {
        _tokens[token].balanceReference = newReference;
        emit SetBalanceReference(token, newReference);
    }

    /// @notice Check if the token has the 0x address.
    /// @param token Address of the token.
    /// @return Whether the token's address is the 0x address.
    function _isGasToken(address token) private pure returns (bool) {
        return token == address(0);
    }

    /// @notice Deposit funds in the bank to allow gamers to win more.
    /// It is also setting the new balance reference, used to manage the bank overflow.
    /// ERC20 token allowance should be given prior to deposit.
    /// @param token Address of the token.
    /// @param amount Number of tokens.
    function deposit(address token, uint256 amount)
        external
        payable
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        uint256 balance = getBalance(token);
        if (_isGasToken(token)) {
            _setBalanceReference(token, balance);
            amount = msg.value;
        } else {
            _setBalanceReference(token, balance + amount);
            IERC20(token).safeTransferFrom(msg.sender, address(this), amount);
        }
        emit Deposit(token, amount);
    }

    /// @notice Withdraw funds from the bank to migrate.
    /// It is also setting the new balance reference, used to manage the bank overflow.
    /// @param token Address of the token.
    /// @param amount Number of tokens.
    function withdraw(address token, uint256 amount)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        _setBalanceReference(token, getBalance(token) - amount);
        _safeTransfer(payable(msg.sender), token, amount);
        emit Withdraw(token, amount);
    }

    /// @notice Sets the new balance risk.
    /// @param _balanceRisk Risk rate.
    function setBalanceRisk(uint16 _balanceRisk)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        balanceRisk = _balanceRisk;
        emit SetBalanceRisk(_balanceRisk);
    }

    /// @notice Adds a new token that'll be enabled for the games' betting.
    /// Token shouldn't exist yet.
    /// @param token Address of the token.
    function addToken(address token) external onlyRole(DEFAULT_ADMIN_ROLE) {
        uint16 tokensCount = _tokensCount;
        if (tokensCount > 0) {
            for (uint16 i; i < tokensCount; i++) {
                if (_tokensList[i] == token) {
                    revert TokenExists(token);
                }
            }
        }
        _tokensList[_tokensCount] = token;
        _tokensCount += 1;
        emit AddToken(token);
    }

    /// @notice Changes the token's bet permission on an already added token.
    /// @param token Address of the token.
    /// @param allowed Whether the token is enabled for bets.
    function setAllowedToken(address token, bool allowed)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        _tokens[token].allowed = allowed;
        emit SetAllowedToken(token, allowed);
    }

    /// @notice Sets the token's house edge allocations for bet payout.
    /// @param token Address of the token.
    /// @param dividend Rate to be allocated as staking rewards, on bet payout.
    /// @param referral Rate to be allocated to the referrers, on bet payout.
    /// @param _treasury Rate to be allocated to the treasury, on bet payout.
    /// @param team Rate to be allocated to the team, on bet payout.
    /// @dev `dividend`, `referral`, `_treasury` and `team` rates sum must equals 10000.
    function setHouseEdgeSplit(
        address token,
        uint16 dividend,
        uint16 referral,
        uint16 _treasury,
        uint16 team
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        uint16 splitSum = dividend + team + _treasury + referral;
        if (splitSum != 10000) {
            revert WrongHouseEdgeSplit(splitSum);
        }

        HouseEdgeSplit storage tokenHouseEdge = _tokens[token].houseEdgeSplit;
        tokenHouseEdge.dividend = dividend;
        tokenHouseEdge.referral = referral;
        tokenHouseEdge.treasury = _treasury;
        tokenHouseEdge.team = team;

        emit SetTokenHouseEdgeSplit(token, dividend, referral, _treasury, team);
    }

    /// @notice Sets the token's house edge allocations for bet amount cash-in.
    /// @param token Address of the token.
    /// @param cashInDividend Rate to be allocated as staking rewards, on bet cash in.
    /// @param cashInReferral Rate to be allocated to the referrers, on bet cash in.
    /// @param cashInTreasury Rate to be allocated to the treasury, on bet cash in.
    /// @param cashInTeam Rate to be allocated to the team, on bet cash in.
    /// @dev `cashInDividend`, `cashInReferral`, `cashInTreasury` and `cashInTeam` rates sum must equals 10000.
    function setCashInHouseEdgeSplit(
        address token,
        uint16 cashInDividend,
        uint16 cashInReferral,
        uint16 cashInTreasury,
        uint16 cashInTeam
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        uint16 splitSum = cashInDividend +
            cashInTeam +
            cashInTreasury +
            cashInReferral;
        if (splitSum != 10000) {
            revert WrongHouseEdgeSplit(splitSum);
        }

        HouseEdgeSplit storage tokenHouseEdge = _tokens[token].houseEdgeSplit;
        tokenHouseEdge.cashInDividend = cashInDividend;
        tokenHouseEdge.cashInReferral = cashInReferral;
        tokenHouseEdge.cashInTreasury = cashInTreasury;
        tokenHouseEdge.cashInTeam = cashInTeam;

        emit SetCashInTokenHouseEdgeSplit(
            token,
            cashInDividend,
            cashInReferral,
            cashInTreasury,
            cashInTeam
        );
    }

    /// @notice Distributes the token's treasury and team allocations amounts.
    /// @param token Address of the token.
    function distributeTokenHouseEdgeSplit(address token)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        HouseEdgeSplit storage tokenHouseEdge = _tokens[token].houseEdgeSplit;
        uint256 treasuryAmount = tokenHouseEdge.treasuryAmount;
        uint256 teamAmount = tokenHouseEdge.teamAmount;
        tokenHouseEdge.treasuryAmount = 0;
        tokenHouseEdge.teamAmount = 0;
        _safeTransfer(treasury, token, treasuryAmount);
        _safeTransfer(teamWallet, token, teamAmount);
        emit HouseEdgeDistribution(token, treasuryAmount, teamAmount);
    }

    /// @notice Sets the token's balance overflow management configuration.
    /// The threshold shouldn't exceed 100% to be able to calculate the overflowed amount.
    /// The treasury and team rates sum shouldn't exceed 100% to allow the bank balance to grow organically.
    /// @param token Address of the token.
    /// @param thresholdRate Threshold rate for the token's balance reference.
    /// @param toTreasury Rate to be allocated to the treasury.
    /// @param toTeam Rate to be allocated to the team.
    function setBalanceOverflow(
        address token,
        uint16 thresholdRate,
        uint16 toTreasury,
        uint16 toTeam
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        if (thresholdRate > 10000 || (toTreasury + toTeam) > 10000) {
            revert WrongBalanceOverflow();
        }

        _tokens[token].balanceOverflow = BalanceOverflow(
            thresholdRate,
            toTreasury,
            toTeam
        );
        emit SetBalanceOverflow(token, thresholdRate, toTreasury, toTeam);
    }

    /// @notice Payouts a winning bet, and allocate the house edge fee.
    /// @param user Address of the gamer.
    /// @param token Address of the token.
    /// @param profit Number of tokens to be sent to the gamer.
    /// @param fees Bet amount and bet profit fees amount.
    function payout(
        address payable user,
        address token,
        uint256 profit,
        uint256 fees
    ) external payable onlyRole(GAME_ROLE) {
        HouseEdgeSplit storage tokenHouseEdge = _tokens[token].houseEdgeSplit;
        _allocateHouseEdge(
            user,
            token,
            fees,
            tokenHouseEdge,
            tokenHouseEdge.dividend,
            tokenHouseEdge.referral,
            tokenHouseEdge.treasury,
            tokenHouseEdge.team
        );

        // Pay the user
        _safeTransfer(user, token, profit);

        emit Payout(token, getBalance(token), profit);
    }

    /// @notice Accounts a loss bet, allocate the house edge fee, and manage the balance overflow.
    /// @dev In case of an ERC20, the bet amount should be transfered prior to this tx.
    /// @dev In case of the gas token, the bet amount is sent along with this tx.
    /// @param user Address of the gamer.
    /// @param tokenAddress Address of the token.
    /// @param amount Loss bet amount.
    /// @param fees Bet amount fees amount.
    function cashIn(
        address user,
        address tokenAddress,
        uint256 amount,
        uint256 fees
    ) external payable onlyRole(GAME_ROLE) {
        Token storage token = _tokens[tokenAddress];
        _allocateHouseEdge(
            user,
            tokenAddress,
            fees,
            token.houseEdgeSplit,
            token.houseEdgeSplit.cashInDividend,
            token.houseEdgeSplit.cashInReferral,
            token.houseEdgeSplit.cashInTreasury,
            token.houseEdgeSplit.cashInTeam
        );

        uint256 tokenBalance = getBalance(tokenAddress);
        BalanceOverflow memory balanceOverflow = token.balanceOverflow;
        uint256 overflow = (token.balanceReference +
            ((tokenBalance * balanceOverflow.thresholdRate) / 10000));
        if (tokenBalance > overflow) {
            uint256 diff = tokenBalance - token.balanceReference;
            uint256 overflowAmountToTreasury = ((diff *
                balanceOverflow.toTreasury) / 10000);
            uint256 overflowAmountToTeam = ((diff * balanceOverflow.toTeam) /
                10000);
            _setBalanceReference(
                tokenAddress,
                tokenBalance - overflowAmountToTreasury - overflowAmountToTeam
            );

            uint256 treasuryAmount = token.houseEdgeSplit.treasuryAmount;
            uint256 teamAmount = token.houseEdgeSplit.teamAmount;
            token.houseEdgeSplit.treasuryAmount = 0;
            token.houseEdgeSplit.teamAmount = 0;

            _safeTransfer(
                treasury,
                tokenAddress,
                treasuryAmount + overflowAmountToTreasury
            );
            _safeTransfer(
                teamWallet,
                tokenAddress,
                teamAmount + overflowAmountToTeam
            );
            emit BankOverflowTransfer(
                tokenAddress,
                treasuryAmount + overflowAmountToTreasury,
                teamAmount + overflowAmountToTeam
            );
        }

        emit CashIn(
            tokenAddress,
            getBalance(tokenAddress),
            _isGasToken(tokenAddress) ? msg.value : amount
        );
    }

    /// @dev For the front-end
    function getTokens() external view returns (TokenMetadata[] memory) {
        uint16 tokensCount = _tokensCount;
        TokenMetadata[] memory tokens = new TokenMetadata[](tokensCount);
        for (uint16 i; i < tokensCount; i++) {
            address tokenAddress = _tokensList[i];
            Token memory token = _tokens[tokenAddress];
            if (_isGasToken(tokenAddress)) {
                tokens[i] = TokenMetadata({
                    decimals: 18,
                    tokenAddress: tokenAddress,
                    name: "ETH",
                    symbol: "ETH",
                    token: token
                });
            } else {
                IERC20Metadata erc20Metadata = IERC20Metadata(tokenAddress);
                tokens[i] = TokenMetadata({
                    decimals: erc20Metadata.decimals(),
                    tokenAddress: tokenAddress,
                    name: erc20Metadata.name(),
                    symbol: erc20Metadata.symbol(),
                    token: token
                });
            }
        }
        return tokens;
    }

    /// @notice Calculates the max bet amount based on the token balance, the balance risk, and the game multiplier.
    /// @param token Address of the token.
    /// @param multiplier The bet amount leverage determines the user's profit amount. 10000 = 100% = no profit.
    /// @return Maximum bet amount for the token.
    /// @dev The multiplier should be at least 10000.
    function getMaxBetAmount(address token, uint256 multiplier)
        external
        view
        returns (uint256)
    {
        return (getBalance(token) * balanceRisk) / multiplier;
    }

    /// @notice Gets the token's house edge allocation configuration.
    /// @param token Address of the token.
    /// @return Token's house edge allocations struct.
    function getTokenHouseEdgeSplit(address token)
        external
        view
        returns (HouseEdgeSplit memory)
    {
        return _tokens[token].houseEdgeSplit;
    }

    /// @notice Gets the token's allow status used on the games smart contracts.
    /// @param token Address of the token.
    /// @return Whether the token is enabled for bets.
    function isAllowedToken(address token) external view returns (bool) {
        return _tokens[token].allowed;
    }

    /// @notice Sets the new team wallet.
    /// @param _teamWallet The team wallet address.
    function setTeamWallet(address payable _teamWallet)
        public
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        teamWallet = _teamWallet;
        emit SetTeamWallet(teamWallet);
    }

    /// @notice Sets the new referral program.
    /// @param _referralProgram The referral program address.
    function setReferralProgram(IReferral _referralProgram)
        public
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        referralProgram = _referralProgram;
        emit SetReferralProgram(address(referralProgram));
    }

    /// @notice Gets the token's balance.
    /// The token's house edge allocation amounts are subtracted from the balance.
    /// @param token Address of the token.
    /// @return Whether the token is enabled for bets.
    function getBalance(address token) public view returns (uint256) {
        uint256 balance;
        if (_isGasToken(token)) {
            balance = address(this).balance;
        } else {
            balance = IERC20(token).balanceOf(address(this));
        }
        HouseEdgeSplit memory tokenHouseEdgeSplit = _tokens[token]
            .houseEdgeSplit;
        return
            balance -
            tokenHouseEdgeSplit.dividendAmount -
            tokenHouseEdgeSplit.treasuryAmount -
            tokenHouseEdgeSplit.teamAmount;
    }
}
