// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HiveToken is ERC20 {
    constructor() ERC20("Hive", "HIVE") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }
}
