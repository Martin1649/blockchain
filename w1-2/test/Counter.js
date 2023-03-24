const { ethers } = require("hardhat");
const { expect } = require("chai");

let counter;

describe("Counter", function () {
  async function init() {
    const [owner, otherAccount] = await ethers.getSigners();
    const Counter = await ethers.getContractFactory("Counter");
    counter = await Counter.deploy();
    await counter.deployed();
    console.log("counter:" + counter.address);
  }

  before(async function () {
    await init();
  });

  // 
  it("init equal 0", async function () {
    expect(await counter.get()).to.equal(0);
  });

  it("add 1 equal 1", async function () {
    let tx = await counter.count();
    await tx.wait();
    expect(await counter.get()).to.equal(1);
  });

});
