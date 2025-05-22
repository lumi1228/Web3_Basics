const hre = require("hardhat");
const { expect } = require("chai"); // 引入chai断言库


// 测试套件，测试用例集合
describe("MyToken Test", async()=> {
  const { ethers } = hre; // 引入合约工厂
  const initialSupply = 10000;// 初始供应量
  let MyTokenContract // 定义合约实例
  let account1, account2;

  beforeEach(async() => {
    [account1, account2] = await ethers.getSigners(); // 获取账户list
    console.log("账户: ", account1, account2);


    const MyToken = await ethers.getContractFactory("MyFirstToken"); // 工厂模版，MyToken是合约模版
    // 部署合约, MyTokenContract是合约实例 默认使用第一个账户account1进行部署
    MyTokenContract = await MyToken.deploy(initialSupply);

    // MyTokenContract = await MyToken.connect(account2).deploy(initialSupply);  // 使用第二个账户部署合约

    MyTokenContract.waitForDeployment(); // 等待合约部署完成

    const contractAddress = await MyTokenContract.getAddress();// 获取合约地址
    expect(contractAddress).to.length.greaterThan(0); // 断言合约地址不为空
    console.log("合约地址: ", contractAddress);
  })
  it("验证合约的 name symbol decimals", async()=> {
    const name = await MyTokenContract.name();
    const symbol = await MyTokenContract.symbol();
    const decimals = await MyTokenContract.decimals();
    expect(name).to.equal("MyToken");
    expect(symbol).to.equal("MTK");
    expect(decimals).to.equal(18);
    console.log('decimals',decimals)
    // expect(decimal).to.equal("MyToken");
  })
  it("测试转账", async()=> {
    // const balanceOfAccount1 = await MyTokenContract.balanceOf(account1); // 获取账户余额
    // expect(balanceOfAccount1).to.equal(initialSupply);
    const res = await MyTokenContract.transfer(account2.address, 500); // 向账户2转账100个代币
    console.log(res,'res')
    const balanceOfAccount1 = await MyTokenContract.balanceOf(account1); // 获取账户余额
    console.log("账户1余额: ", balanceOfAccount1);
    expect(balanceOfAccount1).to.equal(initialSupply - 500);
  })
})

// 基础的测试用例
// describe("MyToken Test", async()=> {
//   beforeEach(async() => {
//     console.log("before each 等待2秒...")
//     await new Promise(resolve => {
//       setTimeout(resolve(1), 2000)
//     });
//     console.log("before each 结束, 测试开始...")
//   })
//   it("test1", async()=> {
//     console.log("test1")
//   })
//   it("test2", async()=> {
//     console.log("test2")
//   })
// })