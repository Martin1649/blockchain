const { ethers } = require("hardhat");

async function main() {
  // 获取默认的以太坊账户
  const [deployer] = await ethers.getSigners();

  console.log("部署合约使用的账户：", deployer.address);

  // 部署 Bank 合约
  const Bank = await ethers.getContractFactory("Bank");
  const bank = await Bank.deploy();

  console.log("合约地址：", bank.address);

  // 等待合约部署完成
  await bank.deployed();

  console.log("合约已部署成功！");
}

// 执行部署脚本
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
