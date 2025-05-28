// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// 三个
// * local
// declared inside a function --在函数内部声明
// not stored on the blockchain --没有存储在区块链上

// * state
// declared outside a function --在函数外部声明
// stored on the blockchain。 --存储在区块链上

// * global 
// (provides information about the blockchain)-

contract Variables {
    // State variables 存储在区块链上
    string public text = "Hello";
    uint256 public num = 123;

    function doSomething() public {
        // Local variables 没有存储在区块链上
        uint256 i = 456;
        
        // Here are some global variables
        uint256 timestamp = block.timestamp;  // Current block timestamp
        address sender = msg.sender;  // address of the caller

        // console.log(i);
    }
}