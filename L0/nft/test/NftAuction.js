const {ethers,deployments} = require("hardhat");
const {expect} = require("chai");

// describe("Starting",async function(){
//     it('Should be able to deploy',async function(){
//         const Contract = await ethers.getContractFactory("NftAuction");//获取合约工厂
//         const contract = await Contract.deploy();//部署合约
//         await contract.waitForDeployment();//等待合约部署完成

//         await contract.createAuction(//创建拍卖
//             100*1000,
//             ethers.parseEther("0.000000000000000001"),//起拍价 单位是ether=10^18
//             ethers.ZeroAddress,
//             1
//         )

//         const auction = await contract.auctions(0);

//         console.log(auction);

//     })
// })


describe("test upgrade",async function(){
    it('Should be able to deploy',async function(){

        // 1、部署业务合约
        await deployments.fixture(["depolyNftAuction"]);//deployNftAuction 配置的tags
        const nftAuctionProxy = await deployments.get("NftAuctionProxy"); // 获取代理合约的地址

        // 2、调用createAuction创建拍卖
        const ntfAuction = await ethers.getContractAt("NftAuction",nftAuctionProxy.address); // 获取合约实例
        await ntfAuction.createAuction(
            100*1000,
            ethers.parseEther("0.01"),
            ethers.ZeroAddress,
            1
        );
        const auctions = await ntfAuction.auctions(0);
        console.log("创建拍卖成功:",auctions);

        // 3、升级合约
        await deployments.fixture(["upgradeNftAuction"]);
        
        // 获取升级前后的实现合约地址
        const implAddress1 = await upgrades.erc1967.getImplementationAddress(nftAuctionProxy.address);//获取实现合约地址
        const implAddress2 = await upgrades.erc1967.getImplementationAddress(nftAuctionProxy.address);//获取实现合约地址
        console.log("implAddress1::", implAddress1, "\nimplAddress2::", implAddress2);

        // 4、读取合约的action[0] 
        const auction2 = await ntfAuction.auctions(0);
        console.log("升级后读取拍卖成功：", auction2);
        const nftAuctionV2 = await ethers.getContractAt( // 获取合约实例
            "NftAuctionV2",
            nftAuctionProxy.address
        );
        const hello = await nftAuctionV2.testHello()
        console.log("hello::", hello);

        expect(auction2.startTime).to.be.eq(auctions.startTime);

        // await contract.upgradeAuction(0,ethers.parseEther("0.000000000000000001"));

    })
})