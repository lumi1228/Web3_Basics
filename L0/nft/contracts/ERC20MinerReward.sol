// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// 3-4 练习 - 编写⼀个 ERC20 代币合约

contract ERC20MinerReward is ERC20 {
    event LogNewAlert(string description, address indexed _from, uint256 _n);
    // indexed 是关键字，用于标记事件参数为索引。这使得它们可以被用来过滤事件日志

    // 构造函数使用符号 MRW 定义⼀个名为 MinerReward的新 ERC20 代币
    constructor() ERC20("MinerReward", "MRW") {}

    function _reward() public {
         //_mint 是 ERC20 合约提供的内部函数，用于铸造新代币
        _mint(block.coinbase, 20);
        emit LogNewAlert("_rewarded", block.coinbase, block.number);
        // block.coinbase 是当前区块的矿工（或验证者）地址
        // block.number 是当前区块的区块号
    }
}
