// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counters {
    uint256 public count;

    function get() public view returns (uint256) {
        return count;
    }
    // ++1 
    function inc() public {
        count+=1;
    }
    function del() public {
        count-=1;
    }
}