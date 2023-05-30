// scripts/getBalance.js

const { ethers } = require("hardhat");

async function main() {
  const Address = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"; // 替换为你的合约地址
  const balance = await ethers.provider.getBalance(Address);
  console.log("合约地址的余额：", balance.toString());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
