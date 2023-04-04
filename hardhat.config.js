require('@primitivefi/hardhat-dodoc')

module.exports = {
  solidity: '0.8.17',
  dodoc: {
    include: ['Bank', 'Dice', 'CoinToss', 'Roulette', 'RussianRoulette', 'PvPGamesStore', 'BetsToken']
  },
}
