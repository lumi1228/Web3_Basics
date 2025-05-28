// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// 要编写或更新状态变量，您需要发送一个事务。
// 另一方面，您可以免费读取状态变量，而无需支付任何交易费用。

contract SimpleStorage {
    // State variable to store a number
    uint256 public num;
    // You need to send a transaction to write to a state variable.

    function set(uint256 _num) public{
        num = _num;
    }
     // You can read from a state variable without sending a transaction.
    function get() public view returns (uint256) {
        return num;
    }
}