pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyFirstToken is ERC20 { // 继承ERC20合约
    // uint256 initialSupply 是构造函数的参数，表示代币的初始供应量
    // ERC20("MyToken","MTK") 是调用ERC20合约的构造函数，设置代币名称和符号
    constructor(uint256 initialSupply) ERC20("MyToken","MTK") {
        _mint(msg.sender, initialSupply);
    }
}
