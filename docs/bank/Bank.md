# Bank

*Romuald Hog*

> BetSwirl&#39;s Bank

The Bank contract holds the casino&#39;s funds, whitelist the games betting tokens, define the max bet amount based on a risk, payout the bet profit to user and collect the loss bet amount from the game&#39;s contract, split and allocate the house edge taken from each bet (won or loss). The admin role is transfered to a Timelock that execute administrative tasks, only the Games could payout the bet profit from the bank, and send the loss bet amount to the bank.

*All rates are in basis point.*

## Methods

### DEFAULT_ADMIN_ROLE

```solidity
function DEFAULT_ADMIN_ROLE() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### GAME_ROLE

```solidity
function GAME_ROLE() external view returns (bytes32)
```

Role associated to Games smart contracts.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### HARVESTER_ROLE

```solidity
function HARVESTER_ROLE() external view returns (bytes32)
```

Role associated to harvester smart contract.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### addToken

```solidity
function addToken(address token) external nonpayable
```

Adds a new token that&#39;ll be enabled for the games&#39; betting. Token shouldn&#39;t exist yet.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |

### cashIn

```solidity
function cashIn(address tokenAddress, uint256 amount, uint256 fees) external payable
```

Accounts a loss bet.

*In case of an ERC20, the bet amount should be transfered prior to this tx.In case of the gas token, the bet amount is sent along with this tx.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenAddress | address | Address of the token. |
| amount | uint256 | Loss bet amount. |
| fees | uint256 | Bet amount and bet profit fees amount. |

### checkUpkeep

```solidity
function checkUpkeep(bytes checkData) external view returns (bool upkeepNeeded, bytes performData)
```

Runs by Chainlink Keepers at every block to determine if `performUpkeep` should be called.

*`checkData` and `performData` are encoded with types (uint8, address).*

#### Parameters

| Name | Type | Description |
|---|---|---|
| checkData | bytes | Fixed and specified at Upkeep registration. |

#### Returns

| Name | Type | Description |
|---|---|---|
| upkeepNeeded | bool | Boolean that when True will trigger the on-chain performUpkeep call. |
| performData | bytes | Bytes that will be used as input parameter when calling performUpkeep. |

### deposit

```solidity
function deposit(address token, uint256 amount) external payable
```

Deposit funds in the bank to allow gamers to win more. ERC20 token allowance should be given prior to deposit.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| amount | uint256 | Number of tokens. |

### getBalance

```solidity
function getBalance(address token) external view returns (uint256)
```

Gets the token&#39;s balance. The token&#39;s house edge allocation amounts are subtracted from the balance.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | The amount of token available for profits. |

### getMaxBetAmount

```solidity
function getMaxBetAmount(address token, uint256 multiplier) external view returns (uint256)
```

Calculates the max bet amount based on the token balance, the balance risk, and the game multiplier.

*The multiplier should be at least 10000.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| multiplier | uint256 | The bet amount leverage determines the user&#39;s profit amount. 10000 = 100% = no profit. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Maximum bet amount for the token. |

### getMinBetAmount

```solidity
function getMinBetAmount(address token) external view returns (uint256 minBetAmount)
```

Gets the token&#39;s min bet amount.

*The min bet amount should be at least 10000 cause of the `getMaxBetAmount` calculation.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |

#### Returns

| Name | Type | Description |
|---|---|---|
| minBetAmount | uint256 | Min bet amount. |

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) external view returns (bytes32)
```



*Returns the admin role that controls `role`. See {grantRole} and {revokeRole}. To change a role&#39;s admin, use {_setRoleAdmin}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### getRoleMember

```solidity
function getRoleMember(bytes32 role, uint256 index) external view returns (address)
```



*Returns one of the accounts that have `role`. `index` must be a value between 0 and {getRoleMemberCount}, non-inclusive. Role bearers are not sorted in any particular way, and their ordering may change at any point. WARNING: When using {getRoleMember} and {getRoleMemberCount}, make sure you perform all queries on the same block. See the following https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296[forum post] for more information.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| index | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getRoleMemberCount

```solidity
function getRoleMemberCount(bytes32 role) external view returns (uint256)
```



*Returns the number of accounts that have `role`. Can be used together with {getRoleMember} to enumerate all bearers of a role.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getTokenOwner

```solidity
function getTokenOwner(address token) external view returns (address)
```

Gets the token&#39;s owner.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | Address of the owner. |

### getTokens

```solidity
function getTokens() external view returns (struct Bank.TokenMetadata[])
```



*For the front-end*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | Bank.TokenMetadata[] | undefined |

### getVRFSubId

```solidity
function getVRFSubId(address token) external view returns (uint64)
```

Gets the token&#39;s Chainlink VRF v2 Subscription ID.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint64 | Chainlink VRF v2 Subscription ID. |

### grantRole

```solidity
function grantRole(bytes32 role, address account) external nonpayable
```



*Grants `role` to `account`. If `account` had not been already granted `role`, emits a {RoleGranted} event. Requirements: - the caller must have ``role``&#39;s admin role. May emit a {RoleGranted} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### harvestDividends

```solidity
function harvestDividends() external nonpayable
```

Harvests tokens dividends.




### hasRole

```solidity
function hasRole(bytes32 role, address account) external view returns (bool)
```



*Returns `true` if `account` has been granted `role`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isAllowedToken

```solidity
function isAllowedToken(address tokenAddress) external view returns (bool)
```

Gets the token&#39;s allow status used on the games smart contracts.



#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenAddress | address | Address of the token. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | Whether the token is enabled for bets. |

### multicall

```solidity
function multicall(bytes[] data) external nonpayable returns (bytes[] results)
```



*Receives and executes a batch of function calls on this contract.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| data | bytes[] | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| results | bytes[] | undefined |

### payout

```solidity
function payout(address user, address token, uint256 profit, uint256 fees) external payable
```

Payouts a winning bet, and allocate the house edge fee.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | Address of the gamer. |
| token | address | Address of the token. |
| profit | uint256 | Number of tokens to be sent to the gamer. |
| fees | uint256 | Bet amount and bet profit fees amount. |

### performUpkeep

```solidity
function performUpkeep(bytes performData) external nonpayable
```

Executed by Chainlink Keepers when `upkeepNeeded` is true.



#### Parameters

| Name | Type | Description |
|---|---|---|
| performData | bytes | Data which was passed back from `checkUpkeep`. |

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from the calling account. Roles are often managed via {grantRole} and {revokeRole}: this function&#39;s purpose is to provide a mechanism for accounts to lose their privileges if they are compromised (such as when a trusted device is misplaced). If the calling account had been revoked `role`, emits a {RoleRevoked} event. Requirements: - the caller must be `account`. May emit a {RoleRevoked} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from `account`. If `account` had been granted `role`, emits a {RoleRevoked} event. Requirements: - the caller must have ``role``&#39;s admin role. May emit a {RoleRevoked} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### setAllowedToken

```solidity
function setAllowedToken(address token, bool allowed) external nonpayable
```

Changes the token&#39;s bet permission.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| allowed | bool | Whether the token is enabled for bets. |

### setBalanceRisk

```solidity
function setBalanceRisk(address token, uint16 balanceRisk) external nonpayable
```

Sets the new token balance risk.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| balanceRisk | uint16 | Risk rate. |

### setHouseEdgeSplit

```solidity
function setHouseEdgeSplit(address token, uint16 bank, uint16 dividend, uint16 partner, uint16 _treasury, uint16 team) external nonpayable
```

Sets the token&#39;s house edge allocations for bet payout.

*`bank`, `dividend`, `_treasury` and `team` rates sum must equals 10000.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| bank | uint16 | Rate to be allocated to the bank, on bet payout. |
| dividend | uint16 | Rate to be allocated as staking rewards, on bet payout. |
| partner | uint16 | Rate to be allocated to the partner, on bet payout. |
| _treasury | uint16 | Rate to be allocated to the treasury, on bet payout. |
| team | uint16 | Rate to be allocated to the team, on bet payout. |

### setMinHouseEdgeWithdrawAmount

```solidity
function setMinHouseEdgeWithdrawAmount(address token, uint256 minHouseEdgeWithdrawAmount) external nonpayable
```

Changes the token&#39;s Upkeep min transfer amount.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| minHouseEdgeWithdrawAmount | uint256 | Minimum amount of token to allow transfer. |

### setPausedToken

```solidity
function setPausedToken(address token, bool paused) external nonpayable
```

Changes the token&#39;s paused status.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| paused | bool | Whether the token is paused. |

### setTeamWallet

```solidity
function setTeamWallet(address _teamWallet) external nonpayable
```

Sets the new team wallet.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _teamWallet | address | The team wallet address. |

### setTokenMinBetAmount

```solidity
function setTokenMinBetAmount(address token, uint256 tokenMinBetAmount) external nonpayable
```

Sets the minimum bet amount for a specific token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| tokenMinBetAmount | uint256 | Minimum bet amount. |

### setTokenPartner

```solidity
function setTokenPartner(address token, address partner) external nonpayable
```

Changes the token&#39;s partner address. It withdraw the available balance, the partner allocation, and the games&#39; VRF fees.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| partner | address | Address of the partner. |

### setTokenVRFSubId

```solidity
function setTokenVRFSubId(address token, uint64 subId) external nonpayable
```

Sets the Chainlink VRF subscription ID for a specific token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| subId | uint64 | Subscription ID. |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*See {IERC165-supportsInterface}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### teamWallet

```solidity
function teamWallet() external view returns (address)
```

Team wallet.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### tokens

```solidity
function tokens(address) external view returns (bool allowed, bool paused, uint16 balanceRisk, uint64 VRFSubId, address partner, uint256 minBetAmount, uint256 minHouseEdgeWithdrawAmount, struct Bank.HouseEdgeSplit houseEdgeSplit)
```

Maps tokens addresses to token configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| allowed | bool | undefined |
| paused | bool | undefined |
| balanceRisk | uint16 | undefined |
| VRFSubId | uint64 | undefined |
| partner | address | undefined |
| minBetAmount | uint256 | undefined |
| minHouseEdgeWithdrawAmount | uint256 | undefined |
| houseEdgeSplit | Bank.HouseEdgeSplit | undefined |

### treasury

```solidity
function treasury() external view returns (address)
```

Treasury multi-sig wallet.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### withdraw

```solidity
function withdraw(address token, uint256 amount) external nonpayable
```

Withdraw funds from the bank. Token has to be paused and no pending bet resolution on games.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| amount | uint256 | Number of tokens. |

### withdrawHouseEdgeAmount

```solidity
function withdrawHouseEdgeAmount(address tokenAddress) external nonpayable
```

Distributes the token&#39;s treasury and team allocations amounts.



#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenAddress | address | Address of the token. |

### withdrawPartnerAmount

```solidity
function withdrawPartnerAmount(address tokenAddress) external nonpayable
```

Distributes the token&#39;s partner amount.



#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenAddress | address | Address of the token. |



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
event AllocateHouseEdgeAmount(address indexed token, uint256 bank, uint256 dividend, uint256 partner, uint256 treasury, uint256 team)
```

Emitted after the token&#39;s house edge is allocated.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| bank  | uint256 | The number of tokens allocated to bank. |
| dividend  | uint256 | The number of tokens allocated as staking rewards. |
| partner  | uint256 | The number of tokens allocated to the partner. |
| treasury  | uint256 | The number of tokens allocated to the treasury. |
| team  | uint256 | The number of tokens allocated to the team. |

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

### HarvestDividend

```solidity
event HarvestDividend(address indexed token, uint256 amount)
```

Emitted after the token&#39;s dividend allocation is distributed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| amount  | uint256 | The number of tokens sent to the Harvester. |

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

### HouseEdgePartnerDistribution

```solidity
event HouseEdgePartnerDistribution(address indexed token, uint256 partnerAmount)
```

Emitted after the token&#39;s partner allocation is distributed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| partnerAmount  | uint256 | The number of tokens sent to the partner. |

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

### SetBalanceRisk

```solidity
event SetBalanceRisk(address indexed token, uint16 balanceRisk)
```

Emitted after the balance risk is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| balanceRisk  | uint16 | Rate defining the balance risk. |

### SetMinHouseEdgeWithdrawAmount

```solidity
event SetMinHouseEdgeWithdrawAmount(address indexed token, uint256 minHouseEdgeWithdrawAmount)
```

Emitted after the Upkeep minimum transfer amount is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| minHouseEdgeWithdrawAmount  | uint256 | Minimum amount of token to allow transfer. |

### SetPausedToken

```solidity
event SetPausedToken(address indexed token, bool paused)
```

Emitted after a token is paused.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| paused  | bool | Whether the token is paused for betting. |

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
event SetTokenHouseEdgeSplit(address indexed token, uint16 bank, uint16 dividend, uint16 partner, uint16 treasury, uint16 team)
```

Emitted after the token&#39;s house edge allocations for bet payout is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| bank  | uint16 | Rate to be allocated to the bank, on bet payout. |
| dividend  | uint16 | Rate to be allocated as staking rewards, on bet payout. |
| partner  | uint16 | Rate to be allocated to the partner, on bet payout. |
| treasury  | uint16 | Rate to be allocated to the treasury, on bet payout. |
| team  | uint16 | Rate to be allocated to the team, on bet payout. |

### SetTokenMinBetAmount

```solidity
event SetTokenMinBetAmount(address indexed token, uint256 minBetAmount)
```

Emitted after the minimum bet amount is set for a token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| minBetAmount  | uint256 | Minimum bet amount. |

### SetTokenPartner

```solidity
event SetTokenPartner(address indexed token, address partner)
```

Emitted after a token partner is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| partner  | address | Address of the partner. |

### SetTokenVRFSubId

```solidity
event SetTokenVRFSubId(address indexed token, uint64 subId)
```

Emitted after the token&#39;s VRF subscription ID is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| subId  | uint64 | Subscription ID. |

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

### AccessDenied

```solidity
error AccessDenied()
```

Reverting error when sender isn&#39;t allowed.




### TokenExists

```solidity
error TokenExists()
```

Reverting error when trying to add an existing token.




### TokenHasPendingBets

```solidity
error TokenHasPendingBets()
```

Reverting error when token has pending bets on a game.




### TokenNotPaused

```solidity
error TokenNotPaused()
```

Reverting error when withdrawing a non paused token.




### WrongAddress

```solidity
error WrongAddress()
```

Reverting error when team wallet or treasury is the zero address.




### WrongHouseEdgeSplit

```solidity
error WrongHouseEdgeSplit(uint16 splitSum)
```

Reverting error when setting the house edge allocations, but the sum isn&#39;t 100%.



#### Parameters

| Name | Type | Description |
|---|---|---|
| splitSum | uint16 | Sum of the house edge allocations rates. |


