# Dice

*Romuald Hog (based on Yakitori&#39;s Dice)*

> BetSwirl&#39;s Dice game

The game is played with a 100 sided dice. The game&#39;s goal is to guess whether the lucky number will be above your chosen number.

*The cap is the dice number chosen by the gamer.*

## Methods

### MAX_CAP

```solidity
function MAX_CAP() external view returns (uint8)
```

Maximum dice number that a gamer can choose.

*Dice cap 99 gives 1% chance.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined

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
function bets(uint256) external view returns (bool resolved, address payable user, address token, uint256 id, uint256 amount, uint256 blockNumber)
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
function chainlinkCoordinator() external view returns (contract VRFCoordinatorV2Interface)
```

Reference to the VRFCoordinatorV2 deployed contract.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract VRFCoordinatorV2Interface | undefined

### diceBets

```solidity
function diceBets(uint256) external view returns (uint8)
```

Maps bets IDs to chosen dice number.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined

### getLastUserBets

```solidity
function getLastUserBets(address user, uint256 dataLength) external view returns (struct Dice.DiceBet[])
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
| _0 | Dice.DiceBet[] | A list of Dice bet.

### getPayout

```solidity
function getPayout(uint256 betAmount, uint8 cap) external pure returns (uint256)
```

Calculates the target payout amount.



#### Parameters

| Name | Type | Description |
|---|---|---|
| betAmount | uint256 | Bet amount.
| cap | uint8 | The chosen dice number.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | The target payout amount.

### inCaseTokensGetStuck

```solidity
function inCaseTokensGetStuck(address token, uint256 amount) external nonpayable
```

Withdraws remaining tokens.

*Useful in case some transfers failed during the bet resolution callback.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token.
| amount | uint256 | Number of tokens.

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

### setHouseEdgeAndMinCap

```solidity
function setHouseEdgeAndMinCap(address token, uint16 _houseEdge) external nonpayable
```

Sets the game house edge rate for a specific token, and the minimum cap to prevent defavorable bets.



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

### tokensHouseEdges

```solidity
function tokensHouseEdges(address) external view returns (uint16)
```

Maps tokens addresses to house edge rate.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint16 | undefined

### tokensMinBetAmount

```solidity
function tokensMinBetAmount(address) external view returns (uint256)
```

Maps tokens addresses to minimum bet amount.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

### tokensMinCap

```solidity
function tokensMinCap(address) external view returns (uint8)
```

Maps the tokens addresses to the minimum cap

*This is used to prevent a user from setting defavorable bet*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined

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
function wager(uint8 cap, address token, uint256 tokenAmount, address referrer) external payable
```

Creates a new bet and stores the chosen dice number.



#### Parameters

| Name | Type | Description |
|---|---|---|
| cap | uint8 | The chosen dice number.
| token | address | Address of the token.
| tokenAmount | uint256 | The number of tokens bet.
| referrer | address | Address of the referrer.



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
event PlaceBet(uint256 id, address indexed user, address indexed token, uint8 cap)
```

Emitted after a bet is placed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | The bet ID. |
| user `indexed` | address | Address of the gamer. |
| token `indexed` | address | Address of the token. |
| cap  | uint8 | The chosen dice number. |

### Roll

```solidity
event Roll(uint256 id, address indexed user, address indexed token, uint256 amount, uint8 cap, uint8 rolled, uint256 payout)
```

Emitted after a bet is rolled.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint256 | The bet ID. |
| user `indexed` | address | Address of the gamer. |
| token `indexed` | address | Address of the token. |
| amount  | uint256 | The bet amount. |
| cap  | uint8 | The chosen dice number. |
| rolled  | uint8 | The rolled dice number. |
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

### SetMinCap

```solidity
event SetMinCap(address indexed token, uint256 minCap)
```

Emitted after the minimum cap is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token `indexed` | address | Address of the token. |
| minCap  | uint256 | The new minimum cap. |

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

### Unpaused

```solidity
event Unpaused(address account)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |



## Errors

### CapNotInRange

```solidity
error CapNotInRange(uint8 cap, uint8 minCap, uint8 maxCap)
```

Provided cap is under the minimum.



#### Parameters

| Name | Type | Description |
|---|---|---|
| cap | uint8 | The cap chosen by user. |
| minCap | uint8 | is the minimum cap defined based on the house edge. |
| maxCap | uint8 | is the maximum cap defined. |

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


