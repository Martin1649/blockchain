require("@nomicfoundation/hardhat-toolbox");
require('hardhat-abi-exporter');
require("./task/balance.js");

let dotenv = require('dotenv')
dotenv.config({ path: "./.env" })

const mnemonic = process.env.MNEMONIC
const scankey1 = process.env.ETHERSCAN_API_KEY
const scankey2 = process.env.POLYGONSCAN_API_KEY
const PRIVATE_KEY1 = process.env.PRIVATEKEY

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
      gas: 1000000,
      accounts: {
        mnemonic: mnemonic,
      },
    },
    goerli: {
      url: "https://eth-goerli.api.onfinality.io/public",
      accounts: [PRIVATE_KEY1],
      chainId: 5,
    },
    mumbai: {
      url: "https://endpoints.omniatech.io/v1/matic/mumbai/public",
      accounts: {
        mnemonic: mnemonic,
      },
      chainId: 80001,
    },
  },
  abiExporter: {
      path: './deployments/abi',
      clear: true,
      flat: true,
      only: [],
      spacing: 2,
      pretty: true,
  },
  etherscan: {
    apiKey: {
      polygonMumbai:scankey2
    }
  },
};
