// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// For and While Loop. ForWhile
// Solidity supports for, while, and do while loops.

// Don't write loops that are unbounded as this can hit the gas limit, causing your transaction to fail.
//不要编写无界循环，因为这会达到gas限制，导致事务失败。

// For the reason above, while and do while loops are rarely used.
//由于上述原因，while和do while循环很少使用。


contract Loop {
    function loop() public pure{
        // for loop
        for (uint256 i = 0; i<10; i++) {
            if(i == 3){
                continue;

            }
            if(i == 5){
                break;
            }
        }
        // while loop
        uint256 j;
        while (j<10){
            j++;
        }
    }
}