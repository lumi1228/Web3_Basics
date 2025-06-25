require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();//dotenv作用是读取.env文件中的环境变量

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks:{ // 网络配置
    sepolia:{// 网络名称
      url:`https://eth-sepolia.g.alchemy.com/v2/${process.env.INFURA_API_KEY}`, // url连接网络
      accounts:[process.env.PRIVATE_KEY] // accounts的作用是提供私钥，用于部署合约到网络上，为什么要用私钥，因为合约部署是需要消耗gas的
    }
  },
  // etherscan:{ //区块链浏览器验证配置
  //   apiKey:process.env.ETHERSCAN_API_KEY, // 用于验证合约源代码
  // }
};

// task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
//   const accounts = await hre.ethers.getSigners();

//   for (const account of accounts) {
//     console.log(account.address);
//   }
// });