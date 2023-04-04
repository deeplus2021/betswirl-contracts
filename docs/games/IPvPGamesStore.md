# IPvPGamesStore









## Methods

### addToken

```solidity
function addToken(address token) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |

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

### setHouseEdgeSplit

```solidity
function setHouseEdgeSplit(address token, uint16 dividend, uint16 treasury, uint16 team, uint16 initiator) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| dividend | uint16 | undefined |
| treasury | uint16 | undefined |
| team | uint16 | undefined |
| initiator | uint16 | undefined |

### setTeamWallet

```solidity
function setTeamWallet(address teamWallet) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| teamWallet | address | undefined |

### setVRFSubId

```solidity
function setVRFSubId(address token, uint64 vrfSubId) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| token | address | undefined |
| vrfSubId | uint64 | undefined |




