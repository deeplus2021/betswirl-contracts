require('@primitivefi/hardhat-dodoc')

module.exports = {
  solidity: '0.8.11',
  dodoc: {
    include: ['Bank', 'Referral', 'Dice', 'CoinToss', 'BetsToken']
  },
}
