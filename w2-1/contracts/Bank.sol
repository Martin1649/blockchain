// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank_1 {
    mapping(address => uint256) public balances;

    event Deposit(address indexed account, uint256 amount);

    // 存款函数，允许用户向合约转账 ETH，并记录转账金额
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // 提款函数，提取所有的 ETH
    function withdraw() external {
        uint256 amount = balances[msg.sender]; // 获取用户余额

        require(amount > 0, "Insufficient balance");

        balances[msg.sender] = 0; // 将用户余额置零

        payable(msg.sender).transfer(amount); // 转账给用户
    }

        // 获取合约地址的余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}