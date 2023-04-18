# Keno









## Methods

### bank

```solidity
function bank() external view returns (contract IBank)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract IBank | undefined |

### bets

```solidity
function bets(uint256) external view returns (bool resolved, address user, address token, uint256 id, uint256 amount, uint256 blockNumber, uint256 payout, uint256 vrfCost)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| resolved | bool | undefined |
| user | address | undefined |
| token | address | undefined |
| id | uint256 | undefined |
| amount | uint256 | undefined |
| blockNumber | uint256 | undefined |
| payout | uint256 | undefined |
| vrfCost | uint256 | undefined |

### gain

```solidity
function gain(address token, uint256 played, uint256 matchCount) external view returns (uint256 _factor)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| played | uint256 | undefined |
| matchCount | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _factor | uint256 | undefined |

### gains

```solidity
function gains(address token) external view returns (uint256 biggestNumber, uint256 maxNumbersPlayed, uint256[] _gains)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| biggestNumber | uint256 | undefined |
| maxNumbersPlayed | uint256 | undefined |
| _gains | uint256[] | undefined |

### getChainlinkConfig

```solidity
function getChainlinkConfig() external view returns (uint16 requestConfirmations, bytes32 keyHash, contract IVRFCoordinatorV2 chainlinkCoordinator, uint256 gasAfterCalculation)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| requestConfirmations | uint16 | undefined |
| keyHash | bytes32 | undefined |
| chainlinkCoordinator | contract IVRFCoordinatorV2 | undefined |
| gasAfterCalculation | uint256 | undefined |

### getChainlinkVRFCost

```solidity
function getChainlinkVRFCost(address token) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getLastUserBets

```solidity
function getLastUserBets(address user, uint256 dataLength) external view returns (struct Keno.FullKenoBet[])
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | undefined |
| dataLength | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | Keno.FullKenoBet[] | undefined |

### getNumbersOutOfRandomWord

```solidity
function getNumbersOutOfRandomWord(address token, uint256 randomWord) external view returns (uint40)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| randomWord | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint40 | undefined |

### hasPendingBets

```solidity
function hasPendingBets(address token) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### kenoBets

```solidity
function kenoBets(uint256) external view returns (uint40 numbers, uint40 rolled)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| numbers | uint40 | undefined |
| rolled | uint40 | undefined |

### multicall

```solidity
function multicall(bytes[] data) external nonpayable returns (bytes[] results)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| data | bytes[] | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| results | bytes[] | undefined |

### owner

```solidity
function owner() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### pause

```solidity
function pause() external nonpayable
```






### paused

```solidity
function paused() external view returns (bool)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### rawFulfillRandomWords

```solidity
function rawFulfillRandomWords(uint256 requestId, uint256[] randomWords) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | uint256 | undefined |
| randomWords | uint256[] | undefined |

### refundBet

```solidity
function refundBet(uint256 id) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint256 | undefined |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```






### setChainlinkConfig

```solidity
function setChainlinkConfig(uint16 requestConfirmations, bytes32 keyHash, uint256 gasAfterCalculation) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestConfirmations | uint16 | undefined |
| keyHash | bytes32 | undefined |
| gasAfterCalculation | uint256 | undefined |

### setHouseEdge

```solidity
function setHouseEdge(address token, uint16 houseEdge) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| houseEdge | uint16 | undefined |

### setVRFCallbackGasLimit

```solidity
function setVRFCallbackGasLimit(address token, uint32 callbackGasLimit) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| callbackGasLimit | uint32 | undefined |

### tokenConfigurations

```solidity
function tokenConfigurations(address) external view returns (uint128 biggestNumber, uint128 maxNumbersPlayed)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| biggestNumber | uint128 | undefined |
| maxNumbersPlayed | uint128 | undefined |

### tokens

```solidity
function tokens(address) external view returns (uint16 houseEdge, uint64 pendingCount, uint32 VRFCallbackGasLimit, uint256 VRFFees)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| houseEdge | uint16 | undefined |
| pendingCount | uint64 | undefined |
| VRFCallbackGasLimit | uint32 | undefined |
| VRFFees | uint256 | undefined |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |

### updateTokenConfig

```solidity
function updateTokenConfig(address token, uint128 newBiggestNumber, uint128 newMaxNumbers) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| newBiggestNumber | uint128 | undefined |
| newMaxNumbers | uint128 | undefined |

### userOverchargedVRFCost

```solidity
function userOverchargedVRFCost(address) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### wager

```solidity
function wager(uint40 numbers, address token, uint256 tokenAmount) external payable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| numbers | uint40 | undefined |
| token | address | undefined |
| tokenAmount | uint256 | undefined |

### withdrawOverchargedVRFCost

```solidity
function withdrawOverchargedVRFCost(address user) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | undefined |

### withdrawTokensVRFFees

```solidity
function withdrawTokensVRFFees(address token) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |



## Events

### AccountOverchargedVRFCost

```solidity
event AccountOverchargedVRFCost(address indexed user, uint256 overchargedVRFCost)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| user `indexed` | address | undefined |
| overchargedVRFCost  | uint256 | undefined |

### BetRefunded

```solidity
event BetRefunded(uint256 id, address user, uint256 amount, uint256 chainlinkVRFCost)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| user  | address | undefined |
| amount  | uint256 | undefined |
| chainlinkVRFCost  | uint256 | undefined |

### DistributeOverchargedVRFCost

```solidity
event DistributeOverchargedVRFCost(address indexed user, uint256 overchargedVRFCost)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| user `indexed` | address | undefined |
| overchargedVRFCost  | uint256 | undefined |

### DistributeTokenVRFFees

```solidity
event DistributeTokenVRFFees(address indexed token, uint256 amount)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| amount  | uint256 | undefined |

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |

### Paused

```solidity
event Paused(address account)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |

### PlaceBet

```solidity
event PlaceBet(uint256 id, address indexed user, address indexed token, uint256 amount, uint256 vrfCost, uint40 numbers)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| user `indexed` | address | undefined |
| token `indexed` | address | undefined |
| amount  | uint256 | undefined |
| vrfCost  | uint256 | undefined |
| numbers  | uint40 | undefined |

### Roll

```solidity
event Roll(uint256 id, address indexed user, address indexed token, uint256 amount, uint40 numbers, uint40 rolled, uint256 payout)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| user `indexed` | address | undefined |
| token `indexed` | address | undefined |
| amount  | uint256 | undefined |
| numbers  | uint40 | undefined |
| rolled  | uint40 | undefined |
| payout  | uint256 | undefined |

### SetChainlinkConfig

```solidity
event SetChainlinkConfig(uint16 requestConfirmations, bytes32 keyHash, uint256 gasAfterCalculation)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestConfirmations  | uint16 | undefined |
| keyHash  | bytes32 | undefined |
| gasAfterCalculation  | uint256 | undefined |

### SetHouseEdge

```solidity
event SetHouseEdge(address indexed token, uint16 houseEdge)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| houseEdge  | uint16 | undefined |

### SetVRFCallbackGasLimit

```solidity
event SetVRFCallbackGasLimit(address indexed token, uint32 callbackGasLimit)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| callbackGasLimit  | uint32 | undefined |

### TokenConfigUpdated

```solidity
event TokenConfigUpdated(address token, uint128 newBiggestNumber, uint128 newMaxNumbers)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token  | address | undefined |
| newBiggestNumber  | uint128 | undefined |
| newMaxNumbers  | uint128 | undefined |

### Unpaused

```solidity
event Unpaused(address account)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |



## Errors

### AccessDenied

```solidity
error AccessDenied()
```






### ExcessiveHouseEdge

```solidity
error ExcessiveHouseEdge()
```






### ForbiddenToken

```solidity
error ForbiddenToken()
```






### InvalidAddress

```solidity
error InvalidAddress()
```






### InvalidLinkWeiPrice

```solidity
error InvalidLinkWeiPrice(int256 linkWei)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| linkWei | int256 | undefined |

### InvalidSettings

```solidity
error InvalidSettings()
```






### NoOverchargedVRFCost

```solidity
error NoOverchargedVRFCost()
```






### NotFulfilled

```solidity
error NotFulfilled()
```






### NotPendingBet

```solidity
error NotPendingBet()
```






### NumbersNotInRange

```solidity
error NumbersNotInRange()
```






### OnlyCoordinatorCanFulfill

```solidity
error OnlyCoordinatorCanFulfill(address have, address want)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| have | address | undefined |
| want | address | undefined |

### TokenHasPendingBets

```solidity
error TokenHasPendingBets()
```






### TooManyNumbersPlayed

```solidity
error TooManyNumbersPlayed()
```






### UnderMinBetAmount

```solidity
error UnderMinBetAmount(uint256 minBetAmount)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| minBetAmount | uint256 | undefined |

### WrongGasValueToCoverFee

```solidity
error WrongGasValueToCoverFee()
```







