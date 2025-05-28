// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Transient Storage -瞬态存储 TransientStorage

// Data stored in transient storage is cleared out after transaction.
// 存储在暂态存储器中的数据在事务完成后被清除。


// Make sure EVM version and VM set to Cancun-//确保EVM版本和虚拟机设置为“Cancun

// Storage - data is stored on the blockchain -//Storage—数据存储在区块链上（类似硬盘）。
// Memory - data is cleared out after a function call --//Memory数据-函数调用后清空内存数据（类似电脑内存）
// Transient storage - data is cleared out after a transaction --///Transient存储——事务完成后清空数据（类似临时缓存）


// 接口定义：用于合约间交互
interface ITest{
    function val() external view returns(uint256); // 读取值
    function test() external; // 测试函数
}

/**
 * 回调合约：演示如何通过fallback接收其他合约的数据
 */
contract callback {
    uint256 public val;
    
    // 当收到无匹配函数的调用时触发
    fallback() external {
        val = ITest(msg.sender).val(); // 调用发送者合约的val()函数获取值 
    }
    // 调用目标合约的test()函数
    function test(address target) external {
        ITest(target).test(); // 调用目标合约的test()函数
    }    
}

/**
 * 普通存储示例：使用永久Storage
 */
contract TestStorage {
    uint256 public val; // 永久存储变量（区块链上）

    function test() public {
        val = 123; // 写入永久存储
        bytes memory b = ""; 
        msg.sender.call(b); 
    }
}

/**
 * 瞬态存储示例：使用tstore/tload操作码
 */
contract TestTransientStorage {
    bytes32 constant SLOT = 0; // 瞬态存储槽位（类似变量地址）

    function test() public {
        // 使用汇编写入瞬态存储槽0，值为321
        assembly {
            tstore(SLOT, 321)
        }
        // 回调调用者合约
        bytes memory b = "";
        msg.sender.call(b);
    }
     // 读取瞬态存储的值
    function val() public view returns (uint256 v) {
        assembly {
            v := tload(SLOT)
        }
    }
}

/**
 * 传统防重入锁：使用永久Storage
 */

contract ReentrancyGuard {
    bool private locked; // 永久存储的锁标志

    // 锁修饰器：防止重入攻击
    modifier lock() {
        require(!locked);
        locked = true;  // 加锁（写Storage）
        _; // 执行函数体
        locked = false; // 解锁（写Storage）
    }

    // 测试函数（消耗约35,313 gas）
    // 35313 gas
    function test() public lock {
        // Ignore call error
        bytes memory b = "";
        msg.sender.call(b);
    }
}

/**
 * 瞬态存储防重入锁：使用tstore/tload
 */

contract ReentrancyGuardTransient {
    bytes32 constant SLOT = 0; // 瞬态存储槽位

    // 瞬态锁修饰器
    modifier lock() {
        assembly {
            // 检查锁是否已启用（读取瞬态存储）
            if tload(SLOT) { revert(0, 0) }
            // 启用锁（写入瞬态存储）
            tstore(SLOT, 1)
        }
        _;// 执行函数体
        assembly {
            // 释放锁（清除瞬态存储）
            tstore(SLOT, 0)
        }
    }

    // 测试函数（消耗约21,887 gas，节省约38%）
    // 21887 gas
    function test() external lock {
        // Ignore call error
        bytes memory b = "";
        msg.sender.call(b);
    }
}

// 这段代码主要演示了 以太坊 Cancun 升级 引入的 瞬态存储（Transient Storage） 特性，通过以下几个方面进行对比：

// ## 存储类型对比：
// 永久存储（Storage）：数据永久保存在区块链上
// 内存（Memory）：函数调用内有效
// 瞬态存储（新增）：交易内有效，交易结束后自动清除

// ## 核心演示：
// TestTransientStorage 合约：使用 tstore/tload 操作码读写瞬态存储
// callback 合约：通过回调机制展示如何获取其他合约的数据

// ## 性能对比：
// ReentrancyGuard：传统防重入锁（使用永久 Storage），消耗约 35,313 gas
// ReentrancyGuardTransient：瞬态存储防重入锁，消耗约 21,887 gas（节省约 38%）

// ## 关键优势：
// Gas 优化：瞬态存储读写成本远低于永久存储
// 简化逻辑：无需手动管理临时数据的生命周期
// 安全性：防重入等场景更高效，避免存储污染

// 使用瞬态存储需要将 EVM 版本设置为 Cancun（当前需在测试网或本地环境测试）。