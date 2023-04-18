require('@primitivefi/hardhat-dodoc')

module.exports = {
  dodoc: {
    include: ['Bank', 'Dice', 'CoinToss', 'Roulette', 'Keno', 'RussianRoulette', 'PvPGamesStore', 'BetsToken']
  },
  solidity: {
    compilers: [
      {
        version: '0.8.17',
        settings: {
          optimizer: {
            enabled: true,
            runs: 80000,
          },
        },
      },
    ],
    overrides: {
      'contracts/games/Keno.sol': {
        version: '0.8.17',
        settings: {
          optimizer: {
            enabled: true,
            runs: 9999,
          },
        },
      },
    },
  },
}
