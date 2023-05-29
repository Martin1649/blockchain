const hre = require("hardhat");

async function main() {
  // 获取默认的账户
  const [deployer] = await hre.ethers.getSigners();

  console.log("部署合约的账户地址：", deployer.address);

  // 编译合约
  const BankContract = await hre.ethers.getContractFactory("Bank_1");
  const bank = await BankContract.deploy();

  // 等待合约部署完成
  await bank.deployed();

  console.log("合约已部署到地址：", bank.address);
}

// 执行部署脚本
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
