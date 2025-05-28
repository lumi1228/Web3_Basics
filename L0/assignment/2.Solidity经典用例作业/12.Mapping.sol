// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Mapping

// Maps are created with the syntax mapping(keyType => valueType).
// 使用语法映射（keyType => valueType）创建映射。

// The keyType can be any built-in value type, bytes, string, or any contract.
// keyType 可以是任何内置值类型、字节、字符串或任何合约。

// valueType can be any type including another mapping or an array.
// valueType 可以是任何类型，包括另一个映射或数组。

// Mappings are not iterable.


// contract Mapping {
//     // Mapping from address to uint
//     mapping(address => uint256) public myMap;

    
    
//     function get(address _addr) public view returns(uint256){
//         // Mapping always returns a value. 映射总是返回一个值。
//         // If the value was never set, it will return the default value.如果没有设置值，它将返回默认值。
//         return myMap[_addr];
//     }

//     function set(address _addr, uint256 _i) public{
//         // Update the value at this address
//         myMap[_addr] = _i;
//     }
//     function remove(address _addr) public {
//         // Reset the value to the default value.
//         delete myMap[_addr];
//     }

    
// }

// 嵌套映射
contract NestedMapping {
    // Nested mapping (mapping from address to another mapping)
    // 嵌套映射（从地址映射到另一个映射）
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _addr1, uint256 _i) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint256 _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint256 _i) public {
        delete nested[_addr1][_i];
    }
}