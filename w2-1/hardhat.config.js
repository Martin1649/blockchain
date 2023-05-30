require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    dev: {
      url: "http://127.0.0.1:8545",
      chainId: 31337,
    },
  },
  paths: {
    // ...其他路径配置
    scripts: "./scripts",
  },
};
