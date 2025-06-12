require("@nomicfoundation/hardhat-toolbox");
require('hardhat-deploy');
require('@openzeppelin/hardhat-upgrades');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.20",
    
  },
  // namedAccounts 用于定义和管理不同网络环境下的账户别名
  namedAccounts:{
    deployer:0,
    player:1,
    admin:2,
    player2:3,
    admin2:4
  }
  // networks:{
  //   sepolia:{
  //     url:`https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
  //     accounts:[process.env.PRIVATE_KEY]
  //   }
  // },
  // paths: {
  //   sources: "./contracts",
  //   tests: "./test",
  //   cache: "./cache",
  //   artifacts: "./artifacts"
  // }
};
