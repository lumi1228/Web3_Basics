// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error
// 错误将撤销在事务期间对状态所做的所有更改。

// 可以通过调用require、revert或assert抛出错误：
// Require用于在执行之前验证输入和条件。
// Revert类似于require。有关详细信息，请参阅下面的代码。
// Assert用于检查不应该为false的代码。断言失败可能意味着存在错误。

// 使用自定义错误来节省gas。

contract myError {
    function testRequire(uint256 _i) public pure {
        // Require应当用于验证如下条件：
        // - 输入参数
        // - 执行前的前置条件
        // - 调用其他函数的返回值
        require(_i > 10,"Input must be greater than 10");
    }
     function testRevert(uint256 _i) public pure {
        // 当需要检查的条件较为复杂时，Revert会很实用。
        // 这段代码实现的功能与上面的示例完全相同
        if (_i <= 8) {
            revert("Input must be greater than 8");
        }
    }



    uint256 public num;

    function testAssert() public view {
        // Assert仅应用于检测内部错误
        // 以及验证不变量

        // 在此我们断言num始终等于0
        // 因为num的值不可能被更新
        assert(num == 0);
    }

    // 自定义错误
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }

}


// 使用实例：
contract Account{
    uint256 public balance;
    uint256 public constant MAX_UINT = 2 ** 256 - 1;
   
    // 存款函数
   function deposit(uint256 _amount) public {
        uint256 oldBalance = balance;
        uint256 newBalance = balance + _amount;

        // 溢出检查：如果balance + _amount >= balance，则加法操作不会溢出
        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;
        // 断言验证：使用assert确保余额更新后不会小于原始值
        assert(balance >= oldBalance);
    }

    // 取款函数
    function withdraw(uint256 _amount) public {
        uint256 oldBalance = balance;
    
        // 如果balance >= _amount，则减法操作不会下溢
        // 使用require和revert进行了两次相同的检查
        require(balance >= _amount, "Underflow");

        if (balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;
        // 使用assert确保取款后的余额不大于原始余额
        assert(balance <= oldBalance);
    }
}