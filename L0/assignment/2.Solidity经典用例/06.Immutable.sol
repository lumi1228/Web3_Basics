// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 不可变变量就像常量。
// 不可变变量的值可以在构造函数内部设置，但之后不能修改。

contract Immutable {
    // coding convention to uppercase constant variables
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor(uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}