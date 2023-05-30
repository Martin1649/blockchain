const { ethers } = require("hardhat");

async function main() {
  // 获取默认的以太坊账户
  const [deployer] = await ethers.getSigners();

  // 获取 Bank 合约实例
  const Bank = await ethers.getContractFactory("Bank");
  const bank = await Bank.attach("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266");

  console.log("调用前合约余额：", (await ethers.provider.getBalance(bank.address)).toString());

  // 调用 withdraw 函数
  await bank.withdraw();

  console.log("调用后合约余额：", (await ethers.provider.getBalance(bank.address)).toString());
}

// 执行调用脚本
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
