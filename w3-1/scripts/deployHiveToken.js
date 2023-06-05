const { ethers } = require("hardhat");

async function main() {
  // 获取部署账户
  const [deployer] = await ethers.getSigners();

  // 编译合约
  const Token = await ethers.getContractFactory("HiveToken");
  
  // 部署合约
  const token = await Token.deploy();
  
  // 等待合约部署完成
  await token.deployed();
  
  // 打印合约地址
  console.log("Token deployed to:", token.address);

  // 打印合约发行的总供应量
  const totalSupply = await token.totalSupply();
  console.log("Total supply:", totalSupply.toString());
}

// 执行脚本
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
