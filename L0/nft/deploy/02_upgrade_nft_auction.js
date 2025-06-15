const { ethers, upgrades } = require("hardhat");//ethers 用于操作以太坊区块 upgrades 用于升级合约
const fs = require('fs'); // 文件操作模块
const path = require('path'); // 路径操作模块

module.exports = async function ({getNamedAccounts, deployments }) {
  const { save } = deployments; // save 保存合约信息到部署文件夹中 deployments文件夹用于保存合约信息
  const { deployer } = await getNamedAccounts(); //deployer 部署者地址
  console.log('部署用户地址：', deployer)

  // 读取 .cache/proxyNftAuction.json 文件
  const storePath = path.resolve(__dirname, "./.cache/proxyNftAuction.json");
  const storeData = fs.readFileSync(storePath, "utf-8"); //readFileSync 读取文件内容
  const { ProxyAddress, implAddress , abi} = JSON.parse(storeData); // ProxyAddress 代理合约地址 implAddress 实现合约地址 abi 用于获取合约的ABI接口
  
  // 升级版的合约 
  const NftAuctionV2 = await ethers.getContractFactory("NftAuctionV2");

  // 升级代理合约
  const nftAuctionProxyV2 = await upgrades.upgradeProxy( 
    ProxyAddress, // 代理合约地址
    NftAuctionV2, // 实现合约
    // {
    //   kind: "uups", // uups升级模式
    //   unsafeAllowCustomTypes: true, // 允许自定义类型
    // }
  );
  await nftAuctionProxyV2.waitForDeployment();
  const proxyAddressV2 = await nftAuctionProxyV2.getAddress(); // 获取代理合约地址

  // 保存新的实现合约地址
  await save("NftAuctionProxyV2", { abi, address: proxyAddressV2 });

  
};
module.exports.tags = ['upgradeNftAuction'];