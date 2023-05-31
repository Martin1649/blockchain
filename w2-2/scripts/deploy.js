const { ethers } = require("hardhat");

async function main() {
  // 部署 Score 合约
  const Score = await ethers.getContractFactory("Score");
  const scoreContract = await Score.deploy();
  await scoreContract.deployed();
  console.log("Score合约已部署到:", scoreContract.address);

  // 部署 Teacher 合约，并传入 Score 合约地址
  const Teacher = await ethers.getContractFactory("Teacher");
  const teacherContract = await Teacher.deploy(scoreContract.address);
  await teacherContract.deployed();
  console.log("Teacher合约已部署到:", teacherContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
