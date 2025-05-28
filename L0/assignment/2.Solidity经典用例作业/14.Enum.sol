// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// Enum--枚举

// Solidity supports enumerables and they are useful to model choice and keep track of state.
// Solidity支持枚举，它们对模型选择和状态跟踪很有用。

// Enums can be declared outside of a contract.
// 枚举可以在合约之外声明。


contract Enum {
    // Enum representing shipping status
    enum Status{
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // Default value is the first element listed in  definition of the type, in this case "Pending"
    // 默认值是类型定义中列出的第一个元素，在本例中为“Pending”
    Status public status;
    
    // Returns uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4

    function get() public view returns (Status) {
        return status;
    }
    // Update status by passing uint into input
    // 通过向输入传递int来更新状态

    function set(Status _status) public {
        status = _status;
    }

    // You can update to a specific enum like this
    // 您可以像这样更新到特定的枚举
    function cancel() public {
        status = Status.Canceled;
    }
    // delete resets the enum to its first value, 0
    function reset() public {
        delete status;
    }
}