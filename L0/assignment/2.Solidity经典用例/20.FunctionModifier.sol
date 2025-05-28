// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Function Modifier 函数修饰符 

// 修饰符是可以在函数调用之前和/或之后运行的代码。

// 修饰语可用于：
// 限制访问
// 验证输入
// 防止重入攻击

contract FunctionModifier {
    // 我们将使用这些变量来演示如何使用函数修饰器
    address public owner;
    uint256 public x = 10;
    bool public locked;
    constructor() {
        // 将交易发送者设置为合约所有者
        owner = msg.sender;
    }
    // 修饰器：检查调用者是否为合约所有者
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // 下划线是函数修饰器中的特殊符号，用于指示Solidity执行被修饰函数的剩余代码
        _;
    }

    // 修饰器可以接受参数。此修饰器检查传入的地址是否非零地址
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validAddress(_newOwner)
    {
        owner = _newOwner;
    }

    // 修饰器可以在函数执行前后执行代码

    // 此修饰器防止函数在执行过程中被再次调用（重入攻击保护）
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }

}