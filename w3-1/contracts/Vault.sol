// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault {
    mapping(address => uint256) private balances;

    // 存款函数，用于存入代币到Vault合约
    function deposit(address tokenAddress, uint256 amount) external {
        IERC20 token = IERC20(tokenAddress);
        uint256 allowance = token.allowance(msg.sender, address(this));
        require(allowance >= amount, "Insufficient allowance"); // 确保授权额度足够

        bool success = token.transferFrom(msg.sender, address(this), amount);
        require(success, "Transfer failed"); // 确保代币转移成功

        balances[msg.sender] += amount; // 记录用户存款金额
    }

    // 取款函数，提取用户自己的存款
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance"); // 确保余额足够

        IERC20 token = IERC20(address(this));
        bool success = token.transfer(msg.sender, amount);
        require(success, "Transfer failed"); // 确保代币转移成功

        balances[msg.sender] -= amount; // 更新用户余额
    }

    // 查询用户余额
    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }
}
