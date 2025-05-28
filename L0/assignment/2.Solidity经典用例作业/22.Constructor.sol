// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Constructor-构造函数
// 构造函数是一个可选函数，在合约创建时执行。

// 如何向构造函数传递参数的示例：

// Base contract X
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// Base contract Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 有两种方式可以初始化带有参数的父合约

// 方式一：在继承列表中直接传递参数
contract B is X("Input to X"), Y("Input to Y") {}

contract C is X, Y {
    // 方式二：在子合约的构造函数中传递参数，类似于函数修饰器的语法
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// 父合约的构造函数始终按照继承声明的顺序被调用
// 无论在子合约构造函数中列出父合约的顺序如何

// 构造函数调用顺序：
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}

// 构造函数调用顺序：
// 1. X
// 2. Y
// 3. E
contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}