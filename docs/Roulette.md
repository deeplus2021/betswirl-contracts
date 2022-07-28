# Roulette



> BetSwirl&#39;s Roulette game

@author Romuald Hog



## Methods

### LINK_ETH_feed

```solidity
function LINK_ETH_feed() external view returns (contract AggregatorV3Interface)
```

Chainlink price feed.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract AggregatorV3Interface | undefined

### bank

```solidity
function bank() external view returns (contract IBank)
```

The bank that manage to payout a won bet and collect a loss bet, and to interact with Referral program.




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

### chainlinkConfig

```solidity
function chainlinkConfig() external view returns (uint64 subId, uint32 callbackGasLimit, uint16 requestConfirmations, bytes32 keyHash)
```

Chainlink VRF configuration state.




#### Returns

| Name | Type | Description |
|---|---|---|
| subId | uint64 | undefined
| callbackGasLimit | uint32 | undefined
| requestConfirmations | uint16 | undefined
| keyHash | bytes32 | undefined

### chainlinkCoordinator

```solidity
function chainlinkCoordinator() external view returns (contract IVRFCoordinatorV2)
```

Reference to the VRFCoordinatorV2 deployed contract.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract IVRFCoordinatorV2 | undefined

### getChainlinkVRFCost

```solidity
function getChainlinkVRFCost() external view returns (uint256)
```

Returns the amount of ETH that should be passed to the wager transaction to cover Chainlink VRF fee.




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

### getPayout

```solidity
function getPayout(uint256 betAmount, uint40 numbers) external pure returns (uint256)
```

Calculates the target payout amount.



#### Parameters

| Name | Type | Description |
|---|---|---|
| betAmount | uint256 | Bet amount.
| numbers | uint40 | The chosen numbers.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | The target payout amount.

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

### referralProgram

```solidity
function referralProgram() external view returns (contract IReferral)
```

Referral program contract.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract IReferral | undefined

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
function setChainlinkConfig(uint64 subId, uint32 callbackGasLimit, uint16 requestConfirmations, bytes32 keyHash) external nonpayable
```

Sets the Chainlink VRF V2 configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| subId | uint64 | Subscription ID.
| callbackGasLimit | uint32 | How much gas you would like in your callback to do work with the random words provided.
| requestConfirmations | uint16 | How many confirmations the Chainlink node should wait before responding.
| keyHash | bytes32 | Hash of the public key used to verify the VRF proof.

### setHouseEdge

```solidity
function setHouseEdge(address token, uint16 _houseEdge) external nonpayable
```

Sets the game house edge rate for a specific token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| _houseEdge | uint16 | House edge rate.

### setReferralProgram

```solidity
function setReferralProgram(contract IReferral _referralProgram) external nonpayable
```

Sets the new referral program.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _referralProgram | contract IReferral | The referral program address.

### setTokenMinBetAmount

```solidity
function setTokenMinBetAmount(address token, uint256 tokenMinBetAmount) external nonpayable
```

Sets the minimum bet amount for a specific token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| tokenMinBetAmount | uint256 | Minimum bet amount.

### setTokenPartner

```solidity
function setTokenPartner(address token, address partner) external nonpayable
```

Changes the token&#39;s partner address.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| partner | address | Address of the partner.

### setTokenVRFSubId

```solidity
function setTokenVRFSubId(address token, uint64 subId) external nonpayable
```

Sets the Chainlink VRF subscription ID for a specific token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| subId | uint64 | Subscription ID.

### tokens

```solidity
function tokens(address) external view returns (uint16 houseEdge, uint64 VRFSubId, address partner, uint256 minBetAmount, uint256 VRFFees)
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
| VRFSubId | uint64 | undefined
| partner | address | undefined
| minBetAmount | uint256 | undefined
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
function wager(uint40 numbers, address token, uint256 tokenAmount, address referrer) external payable
```

Creates a new bet and stores the chosen bet mask.



#### Parameters

| Name | Type | Description |
|---|---|---|
| numbers | uint40 | The chosen numbers.
| token | address | Address of the token.
| tokenAmount | uint256 | The number of tokens bet.
| referrer | address | Address of the referrer.

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

### BankCashInFail

```solidity
event BankCashInFail(uint256 id, uint256 amount, string reason)
```

Emitted after the bet amount transfer to the bank failed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| amount  | uint256 | undefined |
| reason  | string | undefined |

### BankTransferFail

```solidity
event BankTransferFail(uint256 id, uint256 amount, string reason)
```

Emitted after the bet amount ERC20 transfer to the bank failed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| amount  | uint256 | undefined |
| reason  | string | undefined |

### BetAmountFeeTransferFail

```solidity
event BetAmountFeeTransferFail(uint256 id, uint256 amount, string reason)
```

Emitted after the bet amount fee transfer to the bank failed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| amount  | uint256 | undefined |
| reason  | string | undefined |

### BetAmountTransferFail

```solidity
event BetAmountTransferFail(uint256 id, uint256 amount, string reason)
```

Emitted after the bet amount transfer to the user failed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| amount  | uint256 | undefined |
| reason  | string | undefined |

### BetCostRefundFail

```solidity
event BetCostRefundFail(uint256 id, address user, uint256 chainlinkVRFCost)
```

Emitted after the bet resolution cost refund to user failed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| user  | address | undefined |
| chainlinkVRFCost  | uint256 | undefined |

### BetProfitTransferFail

```solidity
event BetProfitTransferFail(uint256 id, uint256 amount, string reason)
```

Emitted after the bet profit transfer to the user failed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| amount  | uint256 | undefined |
| reason  | string | undefined |

### BetRefunded

```solidity
event BetRefunded(uint256 id, address user, uint256 amount)
```

Emitted after the bet amount is transfered to the user.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | undefined |
| user  | address | undefined |
| amount  | uint256 | undefined |

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
event PlaceBet(uint256 id, address indexed user, address indexed token, uint40 numbers)
```

Emitted after a bet is placed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | The bet ID. |
| user `indexed` | address | Address of the gamer. |
| token `indexed` | address | Address of the token. |
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

### SetReferralProgram

```solidity
event SetReferralProgram(address referralProgram)
```

Emitted after the referral program is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| referralProgram  | address | undefined |

### SetTokenMinBetAmount

```solidity
event SetTokenMinBetAmount(address indexed token, uint256 minBetAmount)
```

Emitted after the minimum bet amount is set for a token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| minBetAmount  | uint256 | undefined |

### SetTokenPartner

```solidity
event SetTokenPartner(address indexed token, address partner)
```

Emitted after a token partner is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| partner  | address | undefined |

### SetTokenVRFSubId

```solidity
event SetTokenVRFSubId(address indexed token, uint64 subId)
```

Emitted after the token&#39;s VRF subscription ID is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | undefined |
| subId  | uint64 | undefined |

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




### ExcessiveHouseEdge

```solidity
error ExcessiveHouseEdge(uint16 houseEdge)
```

House edge is capped at 4%.



#### Parameters

| Name | Type | Description |
|---|---|---|
| houseEdge | uint16 | House edge rate. |

### ForbiddenToken

```solidity
error ForbiddenToken(address token)
```

Token is not allowed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Bet&#39;s token address. |

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
error NotFulfilled(uint256 id)
```

Bet isn&#39;t resolved yet.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint256 | Bet ID. |

### NotPendingBet

```solidity
error NotPendingBet(uint256 id)
```

Bet provided doesn&#39;t exist or was already resolved.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint256 | Bet ID. |

### NumbersNotInRange

```solidity
error NumbersNotInRange(uint40 numbers)
```

Provided cap is under the minimum.



#### Parameters

| Name | Type | Description |
|---|---|---|
| numbers | uint40 | The numbers chosen by user. |

### OnlyCoordinatorCanFulfill

```solidity
error OnlyCoordinatorCanFulfill(address have, address want)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| have | address | undefined |
| want | address | undefined |

### UnderMinBetAmount

```solidity
error UnderMinBetAmount(address token, uint256 value)
```

Insufficient bet amount.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Bet&#39;s token address. |
| value | uint256 | Bet amount. |

### WrongGasValueToCoverFee

```solidity
error WrongGasValueToCoverFee()
```

The msg.value is not enough to cover Chainlink&#39;s fee.





