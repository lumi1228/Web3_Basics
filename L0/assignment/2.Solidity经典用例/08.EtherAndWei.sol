// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// Transactions are paid with ether.-交易用以太币支付。

// Similar to how one dollar is equal to 100 cent, one ether is equal to 10(18) wei.
// 类似于1美元等于100美分，1以太等于10（18）威。

contract EtherUnits {
    uint256 public oneWei = 1 wei; // 

    bool public isOneWei = (oneWei == 1); //

    uint256 public oneGwei = 1 gwei; //表示一个 Gwei， 这是相对于 Wei 的大数值
    bool public isOneGwei = (oneGwei == 1e9); // 10^9

    uint256 public oneEther = 1 ether;//表示一个 Ether， 这是相对于 Wei 的最大的单位 (ether = 0.000000001 ether)。
    bool public isOneEther = (oneEther == 1e18); // 10^18
}
