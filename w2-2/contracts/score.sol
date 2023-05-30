// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 定义接口 IScore
interface IScore {
    function addScore(address student, uint256 score) external;
    function updateScore(address student, uint256 score) external;
    function getScore(address student) external view returns (uint256);
}

// 定义 Teacher 合约
contract Teacher {
    // 引入 IScore 接口
    IScore private scoreContract;

    // 初始化时传入 IScore 合约地址
    constructor(IScore _scoreContract) {
        scoreContract = _scoreContract;
    }

    // 修饰器：仅限老师调用
    modifier onlyTeacher() {
        require(msg.sender == address(scoreContract), "Only teacher can call this function");
        _;
    }

    // 添加学生分数
    function addScore(address student, uint256 score) external onlyTeacher {
        require(score <= 100, "Score cannot exceed 100");
        scoreContract.addScore(student, score);
    }

    // 更新学生分数
    function updateScore(address student, uint256 score) external onlyTeacher {
        require(score <= 100, "Score cannot exceed 100");
        scoreContract.updateScore(student, score);
    }
}

// 定义 Score 合约实现 IScore 接口
contract Score is IScore {
    // 记录学生分数
    mapping(address => uint256) private scores;

    // 添加学生分数
    function addScore(address student, uint256 score) external override {
        require(score <= 100, "Score cannot exceed 100");
        scores[student] = score;
    }

    // 更新学生分数
    function updateScore(address student, uint256 score) external override {
        require(score <= 100, "Score cannot exceed 100");
        scores[student] = score;
    }

    // 获取学生分数
    function getScore(address student) external view override returns (uint256) {
        return scores[student];
    }
}
