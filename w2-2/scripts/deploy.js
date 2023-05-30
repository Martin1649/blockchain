const { ethers } = require("hardhat");

async function main() {
  // 部署 Score 合约
  const Score = await ethers.getContractFactory("Score");
  const scoreContract = await Score.deploy();
  await scoreContract.deployed();
  console.log("Score contract deployed to:", scoreContract.address);

  // 部署 Teacher 合约，并传入 Score 合约地址
  const Teacher = await ethers.getContractFactory("Teacher");
  const teacherContract = await Teacher.deploy(scoreContract.address);
  await teacherContract.deployed();
  console.log("Teacher contract deployed to:", teacherContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
