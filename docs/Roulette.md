# Roulette



> BetSwirl&#39;s Roulette game

@author Romuald Hog



## Methods

### bank

```solidity
function bank() external view returns (contract IBank)
```

The bank that manage to payout a won bet and collect a loss bet.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract IBank | undefined

### bets

```solidity
function bets(uint256) external view returns (bool resolved, address payable user, address token, uint256 id, uint256 amount, uint256 blockNumber, uint256 payout, uint256 vrfCost)
```

Maps bets IDs to Bet information.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| resolved | bool | undefined
| user | address payable | undefined
| token | address | undefined
| id | uint256 | undefined
| amount | uint256 | undefined
| blockNumber | uint256 | undefined
| payout | uint256 | undefined
| vrfCost | uint256 | undefined

### getChainlinkConfig

```solidity
function getChainlinkConfig() external view returns (uint16 requestConfirmations, bytes32 keyHash, contract IVRFCoordinatorV2 chainlinkCoordinator)
```

Returns the Chainlink VRF config.




#### Returns

| Name | Type | Description |
|---|---|---|
| requestConfirmations | uint16 | undefined
| keyHash | bytes32 | undefined
| chainlinkCoordinator | contract IVRFCoordinatorV2 | undefined

### getChainlinkVRFCost

```solidity
function getChainlinkVRFCost(address token) external view returns (uint256)
```

Returns the amount of ETH that should be passed to the wager transaction. to cover Chainlink VRF fee.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | The bet resolution cost amount.

### getLastUserBets

```solidity
function getLastUserBets(address user, uint256 dataLength) external view returns (struct Roulette.FullRouletteBet[])
```

Gets the list of the last user bets.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | Address of the gamer.
| dataLength | uint256 | The amount of bets to return.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | Roulette.FullRouletteBet[] | A list of Dice bet.

### hasPendingBets

```solidity
function hasPendingBets(address token) external view returns (bool)
```

Returns whether the token has pending bets.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | Whether the token has pending bets.

### multicall

```solidity
function multicall(bytes[] data) external nonpayable returns (bytes[] results)
```



*Receives and executes a batch of function calls on this contract.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| data | bytes[] | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| results | bytes[] | undefined

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined

### pause

```solidity
function pause() external nonpayable
```

Pauses the contract to disable new bets.




### paused

```solidity
function paused() external view returns (bool)
```



*Returns true if the contract is paused, and false otherwise.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined

### rawFulfillRandomWords

```solidity
function rawFulfillRandomWords(uint256 requestId, uint256[] randomWords) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | uint256 | undefined
| randomWords | uint256[] | undefined

### refundBet

```solidity
function refundBet(uint256 id) external nonpayable
```

Refunds the bet to the user if the Chainlink VRF callback failed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint256 | The Bet ID.

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions anymore. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby removing any functionality that is only available to the owner.*


### rouletteBets

```solidity
function rouletteBets(uint256) external view returns (uint40 numbers, uint8 rolled)
```

Maps bets IDs to chosen numbers.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| numbers | uint40 | undefined
| rolled | uint8 | undefined

### setBank

```solidity
function setBank(contract IBank _bank) external nonpayable
```

Sets the Bank contract.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _bank | contract IBank | Address of the Bank contract.

### setChainlinkConfig

```solidity
function setChainlinkConfig(uint16 requestConfirmations, bytes32 keyHash) external nonpayable
```

Sets the Chainlink VRF V2 configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| requestConfirmations | uint16 | How many confirmations the Chainlink node should wait before responding.
| keyHash | bytes32 | Hash of the public key used to verify the VRF proof.

### setHouseEdge

```solidity
function setHouseEdge(address token, uint16 houseEdge) external nonpayable
```

Sets the game house edge rate for a specific token.

*The house edge rate couldn&#39;t exceed 4%.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| houseEdge | uint16 | House edge rate.

### setVRFCallbackGasLimit

```solidity
function setVRFCallbackGasLimit(address token, uint32 callbackGasLimit) external nonpayable
```

Sets the Chainlink VRF V2 configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined
| callbackGasLimit | uint32 | How much gas is needed in the Chainlink VRF callback.

### tokens

```solidity
function tokens(address) external view returns (uint16 houseEdge, uint64 pendingCount, uint32 VRFCallbackGasLimit, uint256 VRFFees)
```

Maps tokens addresses to token configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| houseEdge | uint16 | undefined
| pendingCount | uint64 | undefined
| VRFCallbackGasLimit | uint32 | undefined
| VRFFees | uint256 | undefined

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined

### wager

```solidity
function wager(uint40 numbers, address token, uint256 tokenAmount) external payable
```

Creates a new bet and stores the chosen bet mask.



#### Parameters

| Name | Type | Description |
|---|---|---|
| numbers | uint40 | The chosen numbers.
| token | address | Address of the token.
| tokenAmount | uint256 | The number of tokens bet.

### withdrawTokensVRFFees

```solidity
function withdrawTokensVRFFees(address token) external nonpayable
```

Distributes the token&#39;s collected Chainlink fees.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.



## Events

### BetRefunded

```solidity
event BetRefunded(uint256 id, address user, uint256 amount, uint256 chainlinkVRFCost)
```

Emitted after the bet amount is transfered to the user.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| user  | address | undefined |
| amount  | uint256 | undefined |
| chainlinkVRFCost  | uint256 | undefined |

### DistributeTokenVRFFees

```solidity
event DistributeTokenVRFFees(address indexed token, uint256 amount)
```

Emitted after the token&#39;s VRF fees amount is transfered to the user.



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

Emitted after a bet is placed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | The bet ID. |
| user `indexed` | address | Address of the gamer. |
| token `indexed` | address | Address of the token. |
| amount  | uint256 | The bet amount. |
| vrfCost  | uint256 | The Chainlink VRF cost paid by player. |
| numbers  | uint40 | The chosen numbers. |

### Roll

```solidity
event Roll(uint256 id, address indexed user, address indexed token, uint256 amount, uint40 numbers, uint8 rolled, uint256 payout)
```

Emitted after a bet is rolled.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | The bet ID. |
| user `indexed` | address | Address of the gamer. |
| token `indexed` | address | Address of the token. |
| amount  | uint256 | The bet amount. |
| numbers  | uint40 | The chosen numbers. |
| rolled  | uint8 | The rolled number. |
| payout  | uint256 | The payout amount. |

### SetBank

```solidity
event SetBank(address bank)
```

Emitted after the bank is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| bank  | address | undefined |

### SetChainlinkConfig

```solidity
event SetChainlinkConfig(uint16 requestConfirmations, bytes32 keyHash)
```

Emitted after the Chainlink config is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| requestConfirmations  | uint16 | undefined |
| keyHash  | bytes32 | undefined |

### SetHouseEdge

```solidity
event SetHouseEdge(address indexed token, uint16 houseEdge)
```

Emitted after the house edge is set for a token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| houseEdge  | uint16 | undefined |

### SetVRFCallbackGasLimit

```solidity
event SetVRFCallbackGasLimit(address indexed token, uint32 callbackGasLimit)
```

Emitted after the Chainlink callback gas limit is set for a token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| callbackGasLimit  | uint32 | undefined |

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

Reverting error when sender isn&#39;t allowed.




### BetVRFCostRefundFailed

```solidity
error BetVRFCostRefundFailed()
```

Reverting error when bet resolution cost refund to user failed.




### ExcessiveHouseEdge

```solidity
error ExcessiveHouseEdge()
```

House edge is capped at 4%.




### ForbiddenToken

```solidity
error ForbiddenToken()
```

Token is not allowed.




### InvalidAddress

```solidity
error InvalidAddress()
```

Reverting error when provided address isn&#39;t valid.




### InvalidLinkWeiPrice

```solidity
error InvalidLinkWeiPrice(int256 linkWei)
```

Chainlink price feed not working



#### Parameters

| Name | Type | Description |
|---|---|---|
| linkWei | int256 | LINK/ETH price returned. |

### NotFulfilled

```solidity
error NotFulfilled()
```

Bet isn&#39;t resolved yet.




### NotPendingBet

```solidity
error NotPendingBet()
```

Bet provided doesn&#39;t exist or was already resolved.




### NumbersNotInRange

```solidity
error NumbersNotInRange()
```

Provided cap is under the minimum.




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

Reverting error when token has pending bets.




### UnderMinBetAmount

```solidity
error UnderMinBetAmount(uint256 minBetAmount)
```

Insufficient bet amount.



#### Parameters

| Name | Type | Description |
|---|---|---|
| minBetAmount | uint256 | Bet amount. |

### WrongGasValueToCoverFee

```solidity
error WrongGasValueToCoverFee()
```

The msg.value is not enough to cover Chainlink&#39;s fee.





