// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// If / Else. IfElse
// Solidity supports conditional statements if, else if and else. 
// Solidity支持条件语句if、else if和else。

contract IfElse {
   

    function foo(uint256 x) public pure returns (uint256) {
        if(x < 10) {
            return 0;
        }else if(x < 20 ) {
            return 1;
        }else {
            return 2;
        }
    }

    function foo2(uint256 _x) public pure returns (uint256) {
        // “？”操作符称为三元操作符
        return _x<10? 1:2;
    }
}