# RussianRoulette









## Methods

### betId

```solidity
function betId() external view returns (uint24)
```

Bet ID nonce.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint24 | undefined |

### betMaxSeats

```solidity
function betMaxSeats(uint24 id) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### betMinSeats

```solidity
function betMinSeats(uint24) external pure returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint24 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### betNFTs

```solidity
function betNFTs(uint24, uint256) external view returns (contract IERC721 nftContract)
```

Maps bet ID -&gt; NFTs struct.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint24 | undefined |
| _1 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| nftContract | contract IERC721 | undefined |

### bets

```solidity
function bets(uint24) external view returns (address token, bool resolved, bool canceled, uint24 id, uint32 vrfRequestTimestamp, uint16 houseEdge, uint256 vrfRequestId, uint256 amount, uint256 payout, uint256 pot)
```

Maps bets IDs to Bet information.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint24 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| resolved | bool | undefined |
| canceled | bool | undefined |
| id | uint24 | undefined |
| vrfRequestTimestamp | uint32 | undefined |
| houseEdge | uint16 | undefined |
| vrfRequestId | uint256 | undefined |
| amount | uint256 | undefined |
| payout | uint256 | undefined |
| pot | uint256 | undefined |

### cancelBet

```solidity
function cancelBet(uint24 id) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | undefined |

### claim

```solidity
function claim(address user, address token) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | undefined |
| token | address | undefined |

### claimAll

```solidity
function claimAll(address user) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | undefined |

### claimNFT

```solidity
function claimNFT(uint24 _betId, uint256 nftIndex, uint256 tokenId) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _betId | uint24 | undefined |
| nftIndex | uint256 | undefined |
| tokenId | uint256 | undefined |

### claimNFTs

```solidity
function claimNFTs(uint24 _betId) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _betId | uint24 | undefined |

### claimedNFTs

```solidity
function claimedNFTs(uint24, contract IERC721, uint256) external view returns (bool)
```

Maps bet ID -&gt; NFT contract -&gt; token ID for claimed NFTs



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint24 | undefined |
| _1 | contract IERC721 | undefined |
| _2 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### gameCanStart

```solidity
function gameCanStart(uint24 id) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### getBetNFTs

```solidity
function getBetNFTs(uint24 id) external view returns (struct PvPGame.NFTs[])
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | PvPGame.NFTs[] | undefined |

### getChainlinkConfig

```solidity
function getChainlinkConfig() external view returns (uint16 requestConfirmations, bytes32 keyHash, contract VRFCoordinatorV2Interface chainlinkCoordinator, uint256 gasAfterCalculation)
```

Returns the Chainlink VRF config.




#### Returns

| Name | Type | Description |
|---|---|---|
| requestConfirmations | uint16 | undefined |
| keyHash | bytes32 | undefined |
| chainlinkCoordinator | contract VRFCoordinatorV2Interface | undefined |
| gasAfterCalculation | uint256 | undefined |

### getRussianRouletteBet

```solidity
function getRussianRouletteBet(uint24 id) external view returns (struct RussianRoulette.RussianRouletteBet russianRouletteBet, struct PvPGame.Bet bet)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| russianRouletteBet | RussianRoulette.RussianRouletteBet | undefined |
| bet | PvPGame.Bet | undefined |

### harvestDividends

```solidity
function harvestDividends(address tokenAddress) external nonpayable
```

Harvests tokens dividends.



#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenAddress | address | undefined |

### harvester

```solidity
function harvester() external view returns (address)
```

Address allowed to harvest dividends.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### joinGame

```solidity
function joinGame(uint24 id, uint16 seatsNumber) external payable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | undefined |
| seatsNumber | uint16 | undefined |

### launchGame

```solidity
function launchGame(uint24 id) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | undefined |

### maxNFTs

```solidity
function maxNFTs() external view returns (uint16)
```

Maximum number of NFTs per game.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint16 | undefined |

### maxSeats

```solidity
function maxSeats() external view returns (uint16)
```

Maximum number of seats per game.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint16 | undefined |

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

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

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
| _0 | bool | undefined |

### payouts

```solidity
function payouts(address, address) external view returns (uint256)
```

Maps user -&gt; token -&gt; amount for due payouts



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### pullTriggers

```solidity
function pullTriggers(uint24 id) external nonpayable
```

Pull the triggers killing seats.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | id of the bet |

### pvpGamesStore

```solidity
function pvpGamesStore() external view returns (contract IPvPGamesStore)
```

The PvPGamesStore contract that contains the tokens configuration.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract IPvPGamesStore | undefined |

### rawFulfillRandomWords

```solidity
function rawFulfillRandomWords(uint256 requestId, uint256[] randomWords) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | uint256 | undefined |
| randomWords | uint256[] | undefined |

### readBet

```solidity
function readBet(uint24 id) external view returns (struct PvPGame.Bet bet)
```

Returns the bet with the seats list included



#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| bet | PvPGame.Bet | The required bet |

### refundBet

```solidity
function refundBet(uint24 id) external nonpayable
```

Refunds the bet to the user if the Chainlink VRF callback failed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint24 | The Bet ID. |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions anymore. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby removing any functionality that is only available to the owner.*


### setChainlinkConfig

```solidity
function setChainlinkConfig(uint16 requestConfirmations, bytes32 keyHash, uint256 gasAfterCalculation) external nonpayable
```

Sets the Chainlink VRF V2 configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| requestConfirmations | uint16 | How many confirmations the Chainlink node should wait before responding. |
| keyHash | bytes32 | Hash of the public key used to verify the VRF proof. |
| gasAfterCalculation | uint256 | Gas to be added for VRF cost refund. |

### setHarvester

```solidity
function setHarvester(address newHarvester) external nonpayable
```

Allows to change the harvester address.



#### Parameters

| Name | Type | Description |
|---|---|---|
| newHarvester | address | provides the new address to use. |

### setHouseEdge

```solidity
function setHouseEdge(address token, uint16 houseEdge) external nonpayable
```

Sets the game house edge rate for a specific token.

*The house edge rate couldn&#39;t exceed 4%.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| houseEdge | uint16 | House edge rate. |

### setMaxNFTs

```solidity
function setMaxNFTs(uint16 _maxNFTs) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _maxNFTs | uint16 | undefined |

### setMaxSeats

```solidity
function setMaxSeats(uint16 _maxSeats) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _maxSeats | uint16 | undefined |

### setVRFCallbackGasLimit

```solidity
function setVRFCallbackGasLimit(address token, uint32 callbackGasLimit) external nonpayable
```

Sets the Chainlink VRF V2 configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| callbackGasLimit | uint32 | How much gas is needed in the Chainlink VRF callback. |

### tokens

```solidity
function tokens(address) external view returns (uint16 houseEdge, uint32 VRFCallbackGasLimit, uint256 VRFFees, struct PvPGame.HouseEdgeSplit houseEdgeSplit)
```

Maps tokens addresses to token configuration.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| houseEdge | uint16 | undefined |
| VRFCallbackGasLimit | uint32 | undefined |
| VRFFees | uint256 | undefined |
| houseEdgeSplit | PvPGame.HouseEdgeSplit | undefined |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |

### wager

```solidity
function wager(address token, uint256 tokenAmount, address[] opponents, uint16 _maxSeats, uint32 startsAt, uint8 deathRatio, bytes nfts) external payable
```

Creates a new bet and stores the chosen coin face.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | Address of the token. |
| tokenAmount | uint256 | The number of tokens bet. |
| opponents | address[] | Selected players to play with. |
| _maxSeats | uint16 | Maximum number of seats. The game will start when its reached. |
| startsAt | uint32 | Timestamp when the game can start. |
| deathRatio | uint8 | Players kill rate. |
| nfts | bytes | undefined |

### withdrawHouseEdgeAmount

```solidity
function withdrawHouseEdgeAmount(address tokenAddress) external nonpayable
```

Distributes the token&#39;s treasury and team allocations amounts.



#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenAddress | address | Address of the token. |



## Events

### AddNFTsPrize

```solidity
event AddNFTsPrize(uint24 indexed id, contract IERC721 nftContract, uint256[] tokenIds)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | uint24 | undefined |
| nftContract  | contract IERC721 | undefined |
| tokenIds  | uint256[] | undefined |

### AllocateHouseEdgeAmount

```solidity
event AllocateHouseEdgeAmount(address token, uint256 dividend, uint256 treasury, uint256 team, uint256 initiator)
```

Emitted after the token&#39;s house edge is allocated.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token  | address | undefined |
| dividend  | uint256 | undefined |
| treasury  | uint256 | undefined |
| team  | uint256 | undefined |
| initiator  | uint256 | undefined |

### BetCanceled

```solidity
event BetCanceled(uint24 id, address user, uint256 amount)
```

Emitted after the bet is canceled.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint24 | undefined |
| user  | address | undefined |
| amount  | uint256 | undefined |

### BetRefunded

```solidity
event BetRefunded(uint24 indexed id, address[] seats, uint256 amount)
```

Emitted after the bet amount is transfered to the user.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | uint24 | undefined |
| seats  | address[] | undefined |
| amount  | uint256 | undefined |

### ClaimedNFT

```solidity
event ClaimedNFT(uint24 indexed id, contract IERC721 nftContract, uint256 tokenId)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | uint24 | undefined |
| nftContract  | contract IERC721 | undefined |
| tokenId  | uint256 | undefined |

### GameResolved

```solidity
event GameResolved(uint24 indexed id, uint256 killedSeatsNumber)
```

Emitted when chainlink&#39;s resolution appens



#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | uint24 | The bet ID. |
| killedSeatsNumber  | uint256 | Killed seats. |

### GameStarted

```solidity
event GameStarted(uint24 indexed id)
```

Emitted after the bet is started.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | uint24 | undefined |

### HarvestDividend

```solidity
event HarvestDividend(address token, uint256 amount)
```

Emitted after the token&#39;s dividend allocation is distributed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token  | address | undefined |
| amount  | uint256 | undefined |

### HarvesterSet

```solidity
event HarvesterSet(address newHarvester)
```

Emitted when a new harvester is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| newHarvester  | address | undefined |

### HouseEdgeDistribution

```solidity
event HouseEdgeDistribution(address token, uint256 treasuryAmount, uint256 teamAmount)
```

Emitted after the token&#39;s treasury and team allocations are distributed.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token  | address | undefined |
| treasuryAmount  | uint256 | undefined |
| teamAmount  | uint256 | undefined |

### Joined

```solidity
event Joined(uint24 indexed id, address player, uint256 pot, uint256 received, uint16 seatsNumber)
```

Emitted after a player joined seat(s)



#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | uint24 | undefined |
| player  | address | undefined |
| pot  | uint256 | undefined |
| received  | uint256 | undefined |
| seatsNumber  | uint16 | undefined |

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

### PayoutsClaimed

```solidity
event PayoutsClaimed(address indexed user, address indexed token, uint256 amount)
```

Emitted after a player claimed his payouts.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user `indexed` | address | undefined |
| token `indexed` | address | undefined |
| amount  | uint256 | undefined |

### PlaceBet

```solidity
event PlaceBet(uint24 id, address indexed player, address[] opponents, address indexed token, uint256 amount, uint16 maxSeats, uint32 startsAt, uint8 deathRatio, uint256 pot)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id  | uint24 | undefined |
| player `indexed` | address | undefined |
| opponents  | address[] | undefined |
| token `indexed` | address | undefined |
| amount  | uint256 | undefined |
| maxSeats  | uint16 | undefined |
| startsAt  | uint32 | undefined |
| deathRatio  | uint8 | undefined |
| pot  | uint256 | undefined |

### Roll

```solidity
event Roll(uint24 indexed id, address[] seats, address[] winners, address[] killedSeats, address indexed token, uint256 betAmount, uint256 payout)
```

Emitted after a bet is rolled.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | uint24 | The bet ID. |
| seats  | address[] | Players addresses of seats. |
| winners  | address[] | who won. |
| killedSeats  | address[] | the bets won. |
| token `indexed` | address | The token used. |
| betAmount  | uint256 | The bet amount. |
| payout  | uint256 | The payout amount. |

### SetChainlinkConfig

```solidity
event SetChainlinkConfig(uint16 requestConfirmations, bytes32 keyHash, uint256 gasAfterCalculation)
```

Emitted after the Chainlink config is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| requestConfirmations  | uint16 | undefined |
| keyHash  | bytes32 | undefined |
| gasAfterCalculation  | uint256 | undefined |

### SetHouseEdge

```solidity
event SetHouseEdge(address token, uint16 houseEdge)
```

Emitted after the house edge is set for a token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token  | address | undefined |
| houseEdge  | uint16 | undefined |

### SetMaxNFTs

```solidity
event SetMaxNFTs(uint16 maxNFTs)
```

Emitted after the max seats is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| maxNFTs  | uint16 | undefined |

### SetMaxSeats

```solidity
event SetMaxSeats(uint16 maxSeats)
```

Emitted after the max seats is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| maxSeats  | uint16 | undefined |

### SetVRFCallbackGasLimit

```solidity
event SetVRFCallbackGasLimit(address token, uint32 callbackGasLimit)
```

Emitted after the Chainlink callback gas limit is set for a token.



#### Parameters

| Name | Type | Description |
|---|---|---|
| token  | address | undefined |
| callbackGasLimit  | uint32 | undefined |

### Unpaused

```solidity
event Unpaused(address account)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |

### WonNFTs

```solidity
event WonNFTs(uint24 indexed id, contract IERC721 nftContract, address[] winners)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id `indexed` | uint24 | undefined |
| nftContract  | contract IERC721 | undefined |
| winners  | address[] | undefined |



## Errors

### AccessDenied

```solidity
error AccessDenied()
```

Reverting error when sender isn&#39;t allowed.




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




### InvalidDate

```solidity
error InvalidDate()
```






### InvalidDeathRatio

```solidity
error InvalidDeathRatio()
```






### InvalidOpponent

```solidity
error InvalidOpponent(address user)
```

User isn&#39;t one of the defined bet opponents.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | The unallowed opponent address. |

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




### OnlyCoordinatorCanFulfill

```solidity
error OnlyCoordinatorCanFulfill(address have, address want)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| have | address | undefined |
| want | address | undefined |

### TooManyNFTs

```solidity
error TooManyNFTs()
```

The maximum of NFTs is reached




### TooManySeats

```solidity
error TooManySeats()
```

The maximum of seats is reached




### WrongBetAmount

```solidity
error WrongBetAmount(uint256 betAmount)
```

Bet amount isn&#39;t enough to accept bet.



#### Parameters

| Name | Type | Description |
|---|---|---|
| betAmount | uint256 | Bet amount. |

### WrongSeatsNumber

```solidity
error WrongSeatsNumber()
```

Wrong number of seat to launch the game.





