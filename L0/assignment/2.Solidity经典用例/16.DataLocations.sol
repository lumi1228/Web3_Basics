// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Data Locations-数据的位置 
// 数据位置- Storage, Memory and Calldata

// Variables are declared as either storage, memory or calldata to explicitly specify the location of the data.
// 变量声明为存储、内存或calldata，以显式指定数据的位置。

// storage variable is a state variable (store on blockchain) 
// storage 是一个状态变量（存储在区块链上）

// memory variable is in memory and it exists while a function is being called
// memory 在内存中，它在函数被调用时存在

// calldata special data location that contains function arguments
// calldata 包含函数参数的特殊数据位置

contract DataLocations {
    uint256[] public arr; // 状态变量
    mapping(uint256 => address) map; // 状态变量
    struct MyStruct {
        uint256 foo;
    }
    
    mapping(uint256 => MyStruct) myStructs; // 状态变量

    function f() public {
        // call _f with state variables
        // 调用 _f 函数并传递状态变量
        arr.push(1);
        _f(arr, map, myStructs[1]);

        // get a struct from a mapping
        // 从映射中获取一个结构体
        MyStruct storage myStruct = myStructs[1];
        
        // create a struct in memory
        // 在内存中创建一个struct
        MyStruct memory myMemStruct = MyStruct(0);
    }


    function _f(
        uint256[] storage _arr, mapping(uint256 => address) storage _map,MyStruct storage _myStruct
    ) internal {
        // 处理storage变量
        // do something with storage variables
    }

    // You can return memory variables --可以返回 memory-内存 变量
    function g(uint256[] memory _arr) public returns (uint256[] memory) {
        // do something with memory array
    }

    function h(uint256[] calldata _arr) external {
        // do something with calldata array
    }

}



