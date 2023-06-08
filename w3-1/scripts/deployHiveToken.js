// 引入 Hardhat 相关库
const { ethers } = require('hardhat');

// 定义部署函数
async function main() {
  // 获取当前账户
  const [deployer] = await ethers.getSigners();

  console.log('Deploying contracts with the account:', deployer.address);

  // 部署 ERC20 合约
  const ERC20 = await ethers.getContractFactory('ERC20');
  const erc20 = await ERC20.deploy('hive', 'HIVE', 100000);

  console.log('ERC20 deployed to:', erc20.address);
}

// 调用部署函数
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
