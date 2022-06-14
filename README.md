# BetSwirl's Smart-Contracts

## Contracts

| Name       | Source                                   | Documentation              | Code flow                       | Audit                                                                                 |
| ---------- | ---------------------------------------- | -------------------------- | ------------------------------- | ------------------------------------------------------------------------------------- |
| BETS token | [source](./contracts/BetsToken.sol)      | [doc](./docs/BetsToken.md) | [graph](./graphs/BetsToken.svg) | [RD Auditors](./audits/BetSwirl-Token_Smart_Contract_Security_Report_03.03.22.pdf)    |
| Bank v2       | [source](./contracts/bank/Bank.sol)      | [doc](./docs/Bank.md)      | [graph](./graphs/Bank.svg)      | [RD Auditors (deprecated)](./audits/BetSwirl-Bank_Smart_Contract_Security_Report_03.03.22.pdf)     |
| Referral   | [source](./contracts/bank/Referral.sol)  | [doc](./docs/Referral.md)  | [graph](./graphs/Referral.svg)  | [RD Auditors](./audits/BetSwirl-Referral_Smart_Contract_Security_Report.pdf) |
| Dice v3      | [source](./contracts/games/Dice.sol)     | [doc](./docs/Dice.md)      | [graph](./graphs/Dice.svg)      | [RD Auditors (deprecated)](./audits/BetSwirl-Dice_Smart_Contract_Security_Report_03.03.22.pdf)     |
| CoinToss v3  | [source](./contracts/games/CoinToss.sol) | [doc](./docs/CoinToss.md)  | [graph](./graphs/CoinToss.svg)  | [RD Auditors (deprecated)](./audits/BetSwirl-CoinToss_Smart_Contract_Security_Report_03.03.22.pdf) |

## Deployments

[Listed on the documentation](https://documentation.betswirl.com/ecosystem/contracts)

## Build

1) `npm install`

2) `npm run compile`
