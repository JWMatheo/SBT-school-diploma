const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();
// Install dotenv and hdwallet-provider
module.exports = {

  networks: {
    development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 8545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
    ropsten: {
      provider: () =>new HDWalletProvider({mnemonic: {phrase: `${process.env.MNEMONIC}`},providerOrUrl: `https://ropsten.infura.io/v3/${process.env.INFURA_ID}`,}),
      network_id: '3',
    },
    kovan: {
      provider: () =>new HDWalletProvider({mnemonic: {phrase: `${process.env.MNEMONIC}`},providerOrUrl: `https://kovan.infura.io/v3/${process.env.INFURA_ID}`,}),
      network_id: '42',
    },
    rinkeby: {
      provider: () =>new HDWalletProvider({mnemonic: {phrase: `${process.env.MNEMONIC}`},providerOrUrl: `https://rinkeby.infura.io/v3/${process.env.INFURA_ID}`,}),
      network_id: '4',
    },
    mainnet: {
      provider: () =>new HDWalletProvider({mnemonic: {phrase: `${process.env.MNEMONIC}`},providerOrUrl: `https://mainnet.infura.io/v3/${process.env.INFURA_ID}`,}),
      network_id: '1',
    },
    
  },
  plugins: ["solidity-coverage"],

  mocha: {
    reporter: 'eth-gas-reporter',
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.13",      // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  },
};