require('@primitivefi/hardhat-dodoc')

module.exports = {
  solidity: '0.8.12',
  dodoc: {
    include: ['Bank', 'Referral', 'Dice', 'CoinToss', 'BetsToken']
  },
}
