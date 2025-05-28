// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Events--事件

// 事件 (Event)：合约与区块链外部进行通信的一种机制，会被记录在区块链的日志中
// 事件的一些用例是：
// 监听事件和更新用户界面
// 一种廉价的存储方式


contract Event {
    // 事件声明
    // 最多可以有3个参数被标记为indexed
    // 被标记为indexed的参数可以帮助你通过该参数对日志进行过滤
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
        // emit 关键字：用于触发事件，将事件数据发送到区块链
    }
}