// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Function

// There are several ways to return outputs from a function.
// 有几种方法可以从函数返回输出

// Public functions cannot accept certain data types as inputs or outputs
// 公共函数不能接受某些数据类型作为输入或输出

contract Counters {
    // Functions can return multiple values.
    function returnMany() public pure returns (uint256, bool,uint256) {
        return (1, true, 2);
    }

    // 返回值可以命名。
    function named() public pure returns (uint256 x, bool b, uint256 y) {
        return (1, true, 2);
    }

    // 返回值可以赋给它们的名称。在这种情况下，可以省略return语句。
    function assigned() public pure returns (uint256 x, bool b, uint256 y) {
        x = 1;
        b = true;
        y = 2;
    }
    // 在调用另一个返回多个值的函数时,使用解构赋值。
    function destructuringAssignments()
        public
        pure
        returns (uint256, bool, uint256, uint256, uint256)
    {
        (uint256 i, bool b, uint256 j) = returnMany();

        // 值可以省略。
        (uint256 x,, uint256 y) = (4, 5, 6);
        return (i, b, j, x, y);
    }

    // 不能使用映射（map）作为输入或输出。

    // 可以将数组用于输入
    function arrayInput(uint256[] memory _arr) public {}

    // 可以用数组做输出
    uint256[] public arr;

    function arrayOutput() public view returns (uint256[] memory) {
        return arr;
    }



}

// Call function with key-value inputs
// 使用键值输入调用函数
contract XYZ {
    function someFuncWithManyInputs(
        uint256 x,
        uint256 y,
        uint256 z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint256) {}

    function callFunc() external pure returns (uint256) {
        return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
    }

    // 这里使用了键值输入来传递参数
    function callFuncWithKeyValue() external pure returns (uint256) {
        return someFuncWithManyInputs({
            a: address(0),
            b: true,
            c: "c",
            x: 1,
            y: 2,
            z: 3
        });
    }
}

// View and Pure Functions

// Getter functions can be declared view or pure.

// View function：不会改变状态.
// Pure function ：不修改也不读取任何state变量.

contract ViewAndPure {
    uint256 public x = 1;

    // view-Promise not to modify the state.-保证不更改状态
    function addToX(uint256 y) public view returns (uint256) {
        return x + y;
    }

    // Promise not to modify or read from the state.
    // 保证不会改变或读取任何 state 变量

    function add(uint256 i, uint256 j) public pure returns (uint256) {
        return i + j;
    }
}