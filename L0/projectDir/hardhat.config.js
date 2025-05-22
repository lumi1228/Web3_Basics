require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks:{ // 网络配置
    sepolia:{// 网络名称
      url:`https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`, // 节点地址
      accounts:[process.env.PRIVATE_KEY] // 钱包的私钥
    }
  }
};

// task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
//   const accounts = await hre.ethers.getSigners();

//   for (const account of accounts) {
//     console.log(account.address);
//   }
// });