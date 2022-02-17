# Referral

*Thundercore, customized by Romuald Hog*

> Multi-level referral program



*All rates are in basis point.*

## Methods

### BANK_ROLE

```solidity
function BANK_ROLE() external view returns (bytes32)
```

Role associated to the Bank smart contracts.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined

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

### addReferrer

```solidity
function addReferrer(address user, address referrer) external nonpayable
```

Adds an address as referrer.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | Address of the gamer.
| referrer | address | The address would set as referrer of user.

### getReferralAccount

```solidity
function getReferralAccount(address user) external view returns (struct Referral.Account)
```

Gets the referrer&#39;s account information.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | Address of the referrer.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | Referral.Account | The account information.

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

### hasReferrer

```solidity
function hasReferrer(address user) external view returns (bool)
```

Utils function for check whether an address has the referrer.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | Address of the gamer.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | Whether user has a referrer.

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

### levelRate

```solidity
function levelRate(uint256) external view returns (uint16)
```

The bonus rate for each level.

*The max depth is 3.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint16 | undefined

### onlyRewardActiveReferrers

```solidity
function onlyRewardActiveReferrers() external view returns (bool)
```

The flag to enable not paying to inactive uplines.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined

### paused

```solidity
function paused() external view returns (bool)
```



*Returns true if the contract is paused, and false otherwise.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined

### payReferral

```solidity
function payReferral(address user, address token, uint256 amount) external nonpayable returns (uint256)
```

Calculates and allocate referrer(s) credits to uplines.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | Address of the gamer to find referrer(s).
| token | address | The token to allocate.
| amount | uint256 | The number of tokens allocated for referrer(s).

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

### refereeBonusRateMap

```solidity
function refereeBonusRateMap(uint256) external view returns (uint16 lowerBound, uint16 rate)
```

The bonus rate mapping to each referree amount. The max depth is 3.



#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| lowerBound | uint16 | undefined
| rate | uint16 | undefined

### referralCreditOf

```solidity
function referralCreditOf(address payee, address token) external view returns (uint256)
```

Gets the referrer&#39;s token credits.



#### Parameters

| Name | Type | Description |
|---|---|---|
| payee | address | Address of the referrer.
| token | address | Address of the token.

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | The number of tokens available to withdraw.

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

### secondsUntilInactive

```solidity
function secondsUntilInactive() external view returns (uint24)
```

The seconds that a user does not update will be seen as inactive.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint24 | undefined

### setReferral

```solidity
function setReferral(uint24 _secondsUntilInactive, bool _onlyRewardActiveReferrers, uint16[3] _levelRate, uint16[6] _refereeBonusRateMap) external nonpayable
```

Sets the Referral program configuration.

*The map should be pass as [&lt;lower amount&gt;, &lt;rate&gt;, ....]. For example, you should pass [1, 2500, 5, 5000, 10, 10000].  25%     50%     100%   | ----- | ----- |-----&gt;  1ppl    5ppl    10pplrefereeBonusRateMap&#39;s lower amount should be ascending*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _secondsUntilInactive | uint24 | The seconds that a user does not update will be seen as inactive.
| _onlyRewardActiveReferrers | bool | The flag to enable not paying to inactive uplines.
| _levelRate | uint16[3] | The bonus rate for each level. The max depth is 3.
| _refereeBonusRateMap | uint16[6] | The bonus rate mapping to each referree amount. The max depth is 3.

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

### updateReferrerActivity

```solidity
function updateReferrerActivity(address user) external nonpayable
```

Updates referrer&#39;s last active timestamp.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user | address | Address of the gamer.

### withdrawCredits

```solidity
function withdrawCredits(address[] tokens) external nonpayable
```

Referrer withdraw credits.



#### Parameters

| Name | Type | Description |
|---|---|---|
| tokens | address[] | The tokens addresses.



## Events

### AddReferralCredit

```solidity
event AddReferralCredit(address indexed user, address indexed token, uint256 amount, uint16 indexed level)
```

Emitted after adding credit to a referrer.



#### Parameters

| Name | Type | Description |
|---|---|---|
| user `indexed` | address | Address of the referrer. |
| token `indexed` | address | Address of the token. |
| amount  | uint256 | Amount of credited tokens. |
| level `indexed` | uint16 | The referrer level. |

### Paused

```solidity
event Paused(address account)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |

### RegisteredReferer

```solidity
event RegisteredReferer(address indexed referee, address indexed referrer)
```

Emitted after setting the referrer of a referee.



#### Parameters

| Name | Type | Description |
|---|---|---|
| referee `indexed` | address | The address of the user |
| referrer `indexed` | address | The address would set as referrer of user |

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

### SetLastActiveTimestamp

```solidity
event SetLastActiveTimestamp(address indexed referrer, uint32 lastActiveTimestamp)
```

Emitted after referrer&#39;s activity.



#### Parameters

| Name | Type | Description |
|---|---|---|
| referrer `indexed` | address | The address of the user. |
| lastActiveTimestamp  | uint32 | The last active timestamp of the referrer. |

### SetReferral

```solidity
event SetReferral(uint24 secondsUntilInactive, bool onlyRewardActiveReferrers, uint16[3] levelRate)
```

Emitted after the configuration is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| secondsUntilInactive  | uint24 | The seconds that a user does not update will be seen as inactive. |
| onlyRewardActiveReferrers  | bool | The flag to enable not paying to inactive uplines. |
| levelRate  | uint16[3] | The bonus rate for each level. |

### SetReferreeBonusRate

```solidity
event SetReferreeBonusRate(uint16 lowerBound, uint16 rate)
```

Emitted after a bonus rate configuration is set.



#### Parameters

| Name | Type | Description |
|---|---|---|
| lowerBound  | uint16 | Number of minimum referee to benefit the bonus rate. |
| rate  | uint16 | The bonus rate. |

### Unpaused

```solidity
event Unpaused(address account)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |

### WithdrawnReferralCredit

```solidity
event WithdrawnReferralCredit(address indexed payee, address indexed token, uint256 amount)
```

Emitted after the referrer withdraw credits.



#### Parameters

| Name | Type | Description |
|---|---|---|
| payee `indexed` | address | Address of the referrer. |
| token `indexed` | address | Address of the token. |
| amount  | uint256 | Amount of credited tokens. |



## Errors

### WrongLevelRate

```solidity
error WrongLevelRate()
```

Referral level should be at least one, length not exceed 3, and total not exceed 100%.




### WrongRefereeBonusRate

```solidity
error WrongRefereeBonusRate(uint16 rate)
```

One of referee bonus rate exceeds 100%.



#### Parameters

| Name | Type | Description |
|---|---|---|
| rate | uint16 | The referee bonus rate. |


