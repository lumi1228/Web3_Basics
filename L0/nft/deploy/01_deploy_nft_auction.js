const { deployments,upgrades, ethers } = require('hardhat');

const fs = require('fs'); // 文件操作模块
const path = require('path'); // 路径操作模块

// from 【hardhat-deploy】 official document
module.exports = async ({getNamedAccounts, deployments}) => {
  const {save} = deployments;
  const {deployer} = await getNamedAccounts();

  console.log('部署用户地址：', deployer);

  // ============== 部署可升级合约 - 使用代理模式，支持后续合约升级==============
  // 加载合约
  const NftAuction = await ethers.getContractFactory('NftAuction');
  // 通过代理部署合约
  const nftAuctionProxy = await upgrades.deployProxy(NftAuction, [], {
    initializer: 'initialize',//调用 initialize 函数进行初始化
  });

  // 等待合约部署完成
  await nftAuctionProxy.waitForDeployment();

  const proxyAddress = await nftAuctionProxy.getAddress();
  console.log('代理合约地址：',proxyAddress);
  const implAddress = await upgrades.erc1967.getImplementationAddress(proxyAddress);
  console.log('实现合约地址：',implAddress);// 实现合约地址

  // 存储合约地址等信息 
  const storePath = path.resolve(__dirname, './.cache/proxyNftAuction.json');

  // 确保目录存在
  const cacheDir = path.dirname(storePath);
  if (!fs.existsSync(cacheDir)) {
    fs.mkdirSync(cacheDir, { recursive: true });
  }

  // 存储合约地址等信息到文件
  fs.writeFileSync(storePath, JSON.stringify({
    proxyAddress,
    implAddress,
    abi:NftAuction.interface.format('json'),
  }));
  // 存储合约信息到deployments文件夹下
  await save('NftAuctionProxy', {
    abi:NftAuction.interface.format('json'),
    address: proxyAddress,
  });

//   await deploy('MyContract', {
//     from: deployer,
//     args: ['Hello'],
//     log: true,
//   });
};
module.exports.tags = ['depolyNftAuction'];