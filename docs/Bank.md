# Bank

*Romuald Hog*

> BetSwirl&#39;s Bank

The Bank contract holds the casino&#39;s funds, whitelist the games betting tokens, define the max bet amount based on a risk, payout the bet profit to user and collect the loss bet amount from the game&#39;s contract, split and allocate the house edge taken from each bet (won or loss), manage the tokens balance overflow to dynamically send overflowed tokens to the treasury and team. The admin role is transfered to a Timelock that execute administrative tasks, only the Games could payout the bet profit from the bank, and send the loss bet amount to the bank.

*All rates are in basis point.*

## Methods

### DEFAULT_ADMIN_ROLE

```solidity
function DEFAULT_ADMIN_ROLE() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined

### GAME_ROLE

```solidity
function GAME_ROLE() external view returns (bytes32)
```

Role associated to Games smart contracts.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined

### addToken

```solidity
function addToken(address token) external nonpayable
```

Adds a new token that&#39;ll be enabled for the games&#39; betting. Token shouldn&#39;t exist yet.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.

### balanceRisk

```solidity
function balanceRisk() external view returns (uint16)
```

Defines the maximum bank payout, used to calculate the max bet amount.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint16 | undefined

### cashIn

```solidity
function cashIn(address user, address tokenAddress, uint256 amount, uint256 fees) external payable
```

Accounts a loss bet, allocate the house edge fee, and manage the balance overflow.

*In case of an ERC20, the bet amount should be transfered prior to this tx.In case of the gas token, the bet amount is sent along with this tx.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | Address of the gamer.
| tokenAddress | address | Address of the token.
| amount | uint256 | Loss bet amount.
| fees | uint256 | Bet amount fees amount.

### deposit

```solidity
function deposit(address token, uint256 amount) external payable
```

Deposit funds in the bank to allow gamers to win more. It is also setting the new balance reference, used to manage the bank overflow. ERC20 token allowance should be given prior to deposit.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| amount | uint256 | Number of tokens.

### distributeTokenHouseEdgeSplit

```solidity
function distributeTokenHouseEdgeSplit(address token) external nonpayable
```

Distributes the token&#39;s treasury and team allocations amounts.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.

### getBalance

```solidity
function getBalance(address token) external view returns (uint256)
```

Gets the token&#39;s balance. The token&#39;s house edge allocation amounts are subtracted from the balance.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Whether the token is enabled for bets.

### getMaxBetAmount

```solidity
function getMaxBetAmount(address token, uint256 multiplier) external view returns (uint256)
```

Calculates the max bet amount based on the token balance, the balance risk, and the game multiplier.

*The multiplier should be at least 10000.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| multiplier | uint256 | The bet amount leverage determines the user&#39;s profit amount. 10000 = 100% = no profit.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Maximum bet amount for the token.

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) external view returns (bytes32)
```



*Returns the admin role that controls `role`. See {grantRole} and {revokeRole}. To change a role&#39;s admin, use {_setRoleAdmin}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined

### getTokenHouseEdgeSplit

```solidity
function getTokenHouseEdgeSplit(address token) external view returns (struct Bank.HouseEdgeSplit)
```

Gets the token&#39;s house edge allocation configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | Bank.HouseEdgeSplit | Token&#39;s house edge allocations struct.

### getTokens

```solidity
function getTokens() external view returns (struct Bank.TokenMetadata[])
```



*For the front-end*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | Bank.TokenMetadata[] | undefined

### grantRole

```solidity
function grantRole(bytes32 role, address account) external nonpayable
```



*Grants `role` to `account`. If `account` had not been already granted `role`, emits a {RoleGranted} event. Requirements: - the caller must have ``role``&#39;s admin role.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined
| account | address | undefined

### hasRole

```solidity
function hasRole(bytes32 role, address account) external view returns (bool)
```



*Returns `true` if `account` has been granted `role`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined
| account | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined

### isAllowedToken

```solidity
function isAllowedToken(address token) external view returns (bool)
```

Gets the token&#39;s allow status used on the games smart contracts.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | Whether the token is enabled for bets.

### payout

```solidity
function payout(address payable user, address token, uint256 profit, uint256 fees) external payable
```

Payouts a winning bet, and allocate the house edge fee.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address payable | Address of the gamer.
| token | address | Address of the token.
| profit | uint256 | Number of tokens to be sent to the gamer.
| fees | uint256 | Bet amount and bet profit fees amount.

### referralProgram

```solidity
function referralProgram() external view returns (contract IReferral)
```

Referral program contract.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract IReferral | undefined

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from the calling account. Roles are often managed via {grantRole} and {revokeRole}: this function&#39;s purpose is to provide a mechanism for accounts to lose their privileges if they are compromised (such as when a trusted device is misplaced). If the calling account had been revoked `role`, emits a {RoleRevoked} event. Requirements: - the caller must be `account`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined
| account | address | undefined

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from `account`. If `account` had been granted `role`, emits a {RoleRevoked} event. Requirements: - the caller must have ``role``&#39;s admin role.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined
| account | address | undefined

### setAllowedToken

```solidity
function setAllowedToken(address token, bool allowed) external nonpayable
```

Changes the token&#39;s bet permission on an already added token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| allowed | bool | Whether the token is enabled for bets.

### setBalanceOverflow

```solidity
function setBalanceOverflow(address token, uint16 thresholdRate, uint16 toTreasury, uint16 toTeam) external nonpayable
```

Sets the token&#39;s balance overflow management configuration. The threshold shouldn&#39;t exceed 100% to be able to calculate the overflowed amount. The treasury and team rates sum shouldn&#39;t exceed 100% to allow the bank balance to grow organically.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| thresholdRate | uint16 | Threshold rate for the token&#39;s balance reference.
| toTreasury | uint16 | Rate to be allocated to the treasury.
| toTeam | uint16 | Rate to be allocated to the team.

### setBalanceRisk

```solidity
function setBalanceRisk(uint16 _balanceRisk) external nonpayable
```

Sets the new balance risk.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _balanceRisk | uint16 | Risk rate.

### setCashInHouseEdgeSplit

```solidity
function setCashInHouseEdgeSplit(address token, uint16 cashInDividend, uint16 cashInReferral, uint16 cashInTreasury, uint16 cashInTeam) external nonpayable
```

Sets the token&#39;s house edge allocations for bet amount cash-in.

*`cashInDividend`, `cashInReferral`, `cashInTreasury` and `cashInTeam` rates sum must equals 10000.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| cashInDividend | uint16 | Rate to be allocated as staking rewards, on bet cash in.
| cashInReferral | uint16 | Rate to be allocated to the referrers, on bet cash in.
| cashInTreasury | uint16 | Rate to be allocated to the treasury, on bet cash in.
| cashInTeam | uint16 | Rate to be allocated to the team, on bet cash in.

### setHouseEdgeSplit

```solidity
function setHouseEdgeSplit(address token, uint16 dividend, uint16 referral, uint16 _treasury, uint16 team) external nonpayable
```

Sets the token&#39;s house edge allocations for bet payout.

*`dividend`, `referral`, `_treasury` and `team` rates sum must equals 10000.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| dividend | uint16 | Rate to be allocated as staking rewards, on bet payout.
| referral | uint16 | Rate to be allocated to the referrers, on bet payout.
| _treasury | uint16 | Rate to be allocated to the treasury, on bet payout.
| team | uint16 | Rate to be allocated to the team, on bet payout.

### setReferralProgram

```solidity
function setReferralProgram(contract IReferral _referralProgram) external nonpayable
```

Sets the new referral program.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _referralProgram | contract IReferral | The referral program address.

### setTeamWallet

```solidity
function setTeamWallet(address payable _teamWallet) external nonpayable
```

Sets the new team wallet.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _teamWallet | address payable | The team wallet address.

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*See {IERC165-supportsInterface}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined

### teamWallet

```solidity
function teamWallet() external view returns (address payable)
```

Team wallet.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address payable | undefined

### treasury

```solidity
function treasury() external view returns (address payable)
```

Treasury multi-sig wallet.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address payable | undefined

### withdraw

```solidity
function withdraw(address token, uint256 amount) external nonpayable
```

Withdraw funds from the bank to migrate. It is also setting the new balance reference, used to manage the bank overflow.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| amount | uint256 | Number of tokens.



## Events

### AddToken

```solidity
event AddToken(address token)
```

Emitted after a token is added.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token  | address | Address of the token. |

### AllocateHouseEdgeAmount

```solidity
event AllocateHouseEdgeAmount(address indexed token, uint256 dividend, uint256 referral, uint256 treasury, uint256 team)
```

Emitted after the token&#39;s house edge is allocated.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| dividend  | uint256 | The number of tokens allocated as staking rewards. |
| referral  | uint256 | The number of tokens allocated to the referrers. |
| treasury  | uint256 | The number of tokens allocated to the treasury. |
| team  | uint256 | The number of tokens allocated to the team. |

### BankOverflowTransfer

```solidity
event BankOverflowTransfer(address indexed token, uint256 amountToTreasury, uint256 amountToTeam)
```

Emitted after the token&#39;s bank overflow amount is distributed to the treasury and team.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| amountToTreasury  | uint256 | The number of tokens sent to the treasury. |
| amountToTeam  | uint256 | The number of tokens sent to the team. |

### CashIn

```solidity
event CashIn(address indexed token, uint256 newBalance, uint256 amount)
```

Emitted after the bet amount is collected from the game smart contract.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| newBalance  | uint256 | New token balance. |
| amount  | uint256 | Bet amount collected. |

### Deposit

```solidity
event Deposit(address indexed token, uint256 amount)
```

Emitted after a token deposit.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| amount  | uint256 | The number of token deposited. |

### HouseEdgeDistribution

```solidity
event HouseEdgeDistribution(address indexed token, uint256 treasuryAmount, uint256 teamAmount)
```

Emitted after the token&#39;s treasury and team allocations are distributed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| treasuryAmount  | uint256 | The number of tokens sent to the treasury. |
| teamAmount  | uint256 | The number of tokens sent to the team. |

### Payout

```solidity
event Payout(address indexed token, uint256 newBalance, uint256 profit)
```

Emitted after the bet profit amount is sent to the user.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| newBalance  | uint256 | New token balance. |
| profit  | uint256 | Bet profit amount sent. |

### RoleAdminChanged

```solidity
event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| previousAdminRole `indexed` | bytes32 | undefined |
| newAdminRole `indexed` | bytes32 | undefined |

### RoleGranted

```solidity
event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| account `indexed` | address | undefined |
| sender `indexed` | address | undefined |

### RoleRevoked

```solidity
event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| account `indexed` | address | undefined |
| sender `indexed` | address | undefined |

### SetAllowedToken

```solidity
event SetAllowedToken(address indexed token, bool allowed)
```

Emitted after a token is allowed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| allowed  | bool | Whether the token is allowed for betting. |

### SetBalanceOverflow

```solidity
event SetBalanceOverflow(address indexed token, uint16 thresholdRate, uint16 toTreasury, uint16 toTeam)
```

Emitted after the token&#39;s balance overflow management configuration is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| thresholdRate  | uint16 | Threshold rate for the token&#39;s balance reference. |
| toTreasury  | uint16 | Rate to be allocated to the treasury. |
| toTeam  | uint16 | Rate to be allocated to the team. |

### SetBalanceReference

```solidity
event SetBalanceReference(address indexed token, uint256 balanceReference)
```

Emitted after the token&#39;s balance reference is set. This happends on deposit, withdraw and when the bank overflow threashold is reached.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| balanceReference  | uint256 | New balance reference used to determine the bank overflow. |

### SetBalanceRisk

```solidity
event SetBalanceRisk(uint16 balanceRisk)
```

Emitted after the balance risk is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| balanceRisk  | uint16 | Rate defining the balance risk. |

### SetCashInTokenHouseEdgeSplit

```solidity
event SetCashInTokenHouseEdgeSplit(address indexed token, uint16 cashInDividend, uint16 cashInReferral, uint16 cashInTreasury, uint16 cashInTeam)
```

Emitted after the token&#39;s house edge allocations for bet amount cash-in is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| cashInDividend  | uint16 | Rate to be allocated as staking rewards, on bet cash in. |
| cashInReferral  | uint16 | Rate to be allocated to the referrers, on bet cash in. |
| cashInTreasury  | uint16 | Rate to be allocated to the treasury, on bet cash in. |
| cashInTeam  | uint16 | Rate to be allocated to the team, on bet cash in. |

### SetReferralProgram

```solidity
event SetReferralProgram(address referralProgram)
```

Emitted after the referral program is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| referralProgram  | address | The referral program address. |

### SetTeamWallet

```solidity
event SetTeamWallet(address teamWallet)
```

Emitted after the team wallet is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| teamWallet  | address | The team wallet address. |

### SetTokenHouseEdgeSplit

```solidity
event SetTokenHouseEdgeSplit(address indexed token, uint16 dividend, uint16 referral, uint16 treasury, uint16 team)
```

Emitted after the token&#39;s house edge allocations for bet payout is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| dividend  | uint16 | Rate to be allocated as staking rewards, on bet payout. |
| referral  | uint16 | Rate to be allocated to the referrers, on bet payout. |
| treasury  | uint16 | Rate to be allocated to the treasury, on bet payout. |
| team  | uint16 | Rate to be allocated to the team, on bet payout. |

### Withdraw

```solidity
event Withdraw(address indexed token, uint256 amount)
```

Emitted after a token withdrawal.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| amount  | uint256 | The number of token withdrawn. |



## Errors

### TokenExists

```solidity
error TokenExists(address token)
```

Reverting error when trying to add an existing token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |

### WrongBalanceOverflow

```solidity
error WrongBalanceOverflow()
```

Reverting error when setting wrong balance overflow management configuration.




### WrongHouseEdgeSplit

```solidity
error WrongHouseEdgeSplit(uint16 splitSum)
```

Reverting error when setting the house edge allocations, but the sum isn&#39;t 100%.



#### Parameters

| Name | Type | Description |
|---|---|---|
| splitSum | uint16 | Sum of the house edge allocations rates. |


