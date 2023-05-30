// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Bank {
    mapping(address => uint256) private balances; // 记录每个地址的余额

    event Deposit(address indexed account, uint256 amount); // 存款事件
    event Withdrawal(address indexed account, uint256 amount); // 取款事件

    // 存款函数，通过 Metamask 向合约转账 ETH
    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than 0"); // 确保转账金额大于0
        balances[msg.sender] += msg.value; // 增加账户余额
        emit Deposit(msg.sender, msg.value); // 触发存款事件
    }

    // 取款函数，提取出所有的 ETH
    function withdraw() external {
        uint256 amount = balances[msg.sender]; // 获取账户余额
        require(amount > 0, "Insufficient balance"); // 确保余额足够

        balances[msg.sender] = 0; // 清零账户余额

        // 调用合约调用者的可接收ETH的回调函数，将余额转账给调用者
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed"); // 确保转账成功

        emit Withdrawal(msg.sender, amount); // 触发取款事件
    }

    // 查询账户余额
    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }
}
