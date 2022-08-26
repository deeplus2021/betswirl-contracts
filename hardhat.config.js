require('@primitivefi/hardhat-dodoc')

module.exports = {
  solidity: '0.8.16',
  dodoc: {
    include: ['Bank', 'Dice', 'CoinToss', 'Roulette', 'BetsToken']
  },
}
