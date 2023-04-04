# IBank

*Romuald Hog.*



Minimal interface for Bank.



## Methods

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
function getMinBetAmount(address token) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getTokenOwner

```solidity
function getTokenOwner(address token) external view returns (address)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getVRFSubId

```solidity
function getVRFSubId(address token) external view returns (uint64)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint64 | undefined |

### isAllowedToken

```solidity
function isAllowedToken(address token) external view returns (bool)
```

Gets the token&#39;s allow status used on the games smart contracts.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | Whether the token is enabled for bets. |

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




