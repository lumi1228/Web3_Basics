// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// Gas
// How much ether do you need to pay for a transaction?
// You pay gas spent * gas price amount of ether, where

// gas is a unit of computation // 一种计算单位
// gas spent is the total amount of gas used in a transaction // 使用的总数
// gas price is how much ether you are willing to pay per gas // 愿意支付
// Transactions with higher gas price have higher priority to be included in a block. // 价格更高的交易有优先权在区块链中

// Unspent gas will be refunded. // 未使用完的将被回退


// Gas Limit
// There are 2 upper bounds to the amount of gas you can spend //  你花费的gas总量有两个限制

// gas limit (max amount of gas you're willing to use for your transaction, set by you)
// 您愿意为您的交易使用的最大gas量，由您设置

// block gas limit (max amount of gas allowed in a block, set by the network)
//一个区块允许的最大gas量，由网络设定


contract Gas {
    uint256 public i = 0;
    // Using up all of the gas that you send causes your transaction to fail.///耗尽你发送的所有gas导致交易失败。
    // State changes are undone.//状态更改被撤消。
    // Gas spent are not refunded. //Gas不退还。

    function forver() public {
        // Here we run a loop until all of the gas are spent //在这里，我们运行一个循环，直到所有的气体被消耗
        // and the transaction fails // 交易失败
        while(true){
            i += 1;
        }
    }
}