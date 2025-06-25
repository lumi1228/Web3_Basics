pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RccToken is ERC20 { // 继承ERC20合约
    // uint256 initialSupply 是构造函数的参数，表示代币的初始供应量
    // ERC20("MyToken","MTK") 是调用ERC20合约的构造函数，设置代币名称和符号
    constructor(uint256 initialSupply) ERC20("MyToken","MTK") { //MyToken是代币的名称，MTK是代币符号
        _mint(msg.sender, initialSupply);//_mint函数用于发行代币，将初始供应量mint给合约的创建者
    }
}
