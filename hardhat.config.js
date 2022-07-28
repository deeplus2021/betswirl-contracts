require('@primitivefi/hardhat-dodoc')

module.exports = {
  solidity: '0.8.14',
  dodoc: {
    include: ['Bank', 'Referral', 'Dice', 'CoinToss', 'Roulette', 'BetsToken']
  },
}
