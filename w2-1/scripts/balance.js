const { ethers } = require("hardhat");

async function main() {
  // 获取默认的以太坊账户
  const [deployer] = await ethers.getSigners();

  // 获取 Bank 合约实例
  const Bank = await ethers.getContractFactory("Bank");
  const bank = await Bank.attach("0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512");

  // 调用 balance 函数
  const balance = await bank.getBalance(deployer.address);

  console.log("合约余额：", balance.toString());
}

// 执行调用脚本
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
