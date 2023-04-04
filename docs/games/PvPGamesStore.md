# PvPGamesStore









## Methods

### addToken

```solidity
function addToken(address token) external nonpayable
```

Adds a new token that&#39;ll be enabled for the games&#39; betting. Token shouldn&#39;t exist yet.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |

### getTokenConfig

```solidity
function getTokenConfig(address token) external view returns (struct IPvPGamesStore.Token config)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| config | IPvPGamesStore.Token | undefined |

### getTokens

```solidity
function getTokens() external view returns (struct IPvPGamesStore.TokenMetadata[])
```



*For the front-end*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | IPvPGamesStore.TokenMetadata[] | undefined |

### getTokensAddresses

```solidity
function getTokensAddresses() external view returns (address[])
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address[] | undefined |

### getTreasuryAndTeamAddresses

```solidity
function getTreasuryAndTeamAddresses() external view returns (address, address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | address | undefined |

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions anymore. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby removing any functionality that is only available to the owner.*


### setHouseEdgeSplit

```solidity
function setHouseEdgeSplit(address token, uint16 dividend, uint16 treasury, uint16 team, uint16 initiator) external nonpayable
```

Sets the token&#39;s house edge allocations for bet payout.

*`dividend`, `_treasuryWallet` and `team` rates sum must equals 10000.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| dividend | uint16 | Rate to be allocated as staking rewards, on bet payout. |
| treasury | uint16 | Rate to be allocated to the treasuryWallet, on bet payout. |
| team | uint16 | Rate to be allocated to the team, on bet payout. |
| initiator | uint16 | Rate to be allocated to the initiator of the bet, on bet payout. |

### setTeamWallet

```solidity
function setTeamWallet(address _teamWallet) external nonpayable
```

Sets the new team wallet.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _teamWallet | address | The team wallet address. |

### setVRFSubId

```solidity
function setVRFSubId(address token, uint64 vrfSubId) external nonpayable
```

Sets the Chainlink VRF subId.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| vrfSubId | uint64 | New subId. |

### teamWallet

```solidity
function teamWallet() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### tokens

```solidity
function tokens(address) external view returns (uint64 vrfSubId, struct IPvPGamesStore.HouseEdgeSplit houseEdgeSplit)
```

Maps tokens addresses to token configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| vrfSubId | uint64 | undefined |
| houseEdgeSplit | IPvPGamesStore.HouseEdgeSplit | undefined |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |

### treasuryWallet

```solidity
function treasuryWallet() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |



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

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |

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





#### Parameters

| Name | Type | Description |
|---|---|---|
| teamWallet  | address | undefined |

### SetTokenHouseEdgeSplit

```solidity
event SetTokenHouseEdgeSplit(address indexed token, uint16 dividend, uint16 treasury, uint16 team, uint16 initiator)
```

Emitted after the token&#39;s house edge allocations for bet payout is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| dividend  | uint16 | Rate to be allocated as staking rewards, on bet payout. |
| treasury  | uint16 | Rate to be allocated to the treasury, on bet payout. |
| team  | uint16 | Rate to be allocated to the team, on bet payout. |
| initiator  | uint16 | undefined |

### SetVRFSubId

```solidity
event SetVRFSubId(address indexed token, uint64 vrfSubId)
```

Emitted after the Chainlink callback subId is set for a token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| vrfSubId  | uint64 | New vrfSubId. |



## Errors

### InvalidAddress

```solidity
error InvalidAddress()
```

Reverting error when provided address isn&#39;t valid.




### TokenExists

```solidity
error TokenExists()
```

Reverting error when trying to add an existing token.




### WrongHouseEdgeSplit

```solidity
error WrongHouseEdgeSplit(uint256 sum)
```

Reverting error when setting the house edge allocations, but the sum isn&#39;t 100%.



#### Parameters

| Name | Type | Description |
|---|---|---|
| sum | uint256 | of the house edge allocations rates. |


