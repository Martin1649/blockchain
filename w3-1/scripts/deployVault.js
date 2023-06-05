const { ethers } = require("hardhat");

async function main() {
  // 获取部署账户
  const [deployer] = await ethers.getSigners();

  // 编译合约
  const Vault = await ethers.getContractFactory("Vault");
  
  // 部署合约
  const vault = await Vault.deploy();
  
  // 等待合约部署完成
  await vault.deployed();
  
  // 打印合约地址
  console.log("Vault deployed to:", vault.address);
}

// 执行脚本
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
