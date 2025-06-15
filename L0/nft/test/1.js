const { ethers, deployments } = require("hardhat") //`
const { expect } = require("chai")


describe("Test auction", async function () {
    it("Should be ok", async function () {
        await main();
    });
})

const zeroAddress = "0x0000000000000000000000000000000000000000";
const sepoliaUsdcAddress = "0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238"

async function main() {
    await deployments.fixture(["depolyNftAuction"]); // 部署合约
    const nftAuctionProxy = await deployments.get("NftAuctionProxy"); // 代理合约地址

    const token2Usd = [{
        token: zeroAddress,
        priceFeed: "0x694AA1769357215DE4FAC081bf1f309aDC325306"
    }, {
        token: sepoliaUsdcAddress,
        priceFeed: "0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E"
    }]

    // for (let i = 0; i < token2Usd.length; i++) {
    //     const { token, priceFeed } = token2Usd[i];
    //     await nftAuctionProxy.setPriceFeed(token, priceFeed);
    // }
    // nftAuctionProxy.setPriceFeed()

    const [signer, buyer] = await ethers.getSigners() //getSigners返回一个包含所有可用账户的数组

    // 1. 部署 ERC721 合约
    const TestERC721 = await ethers.getContractFactory("TestERC721"); // TestERC721 合约工厂
    const testERC721 = await TestERC721.deploy();// 部署合约
    await testERC721.waitForDeployment(); // 等待合约部署完成
    const testERC721Address = await testERC721.getAddress(); // 获取合约地址
    console.log("testERC721Address::", testERC721Address);

    // mint 10个 NFT
    // 铸造5个 NFT 代币，代币 ID 分别为：1, 2, 3, 4, 5；所有代币都发送到 signer.address
    for (let i = 0; i < 10; i++) {
        //mint 铸造函数，用于创建新的 NFT 代币
        await testERC721.mint(signer.address, i + 1); 
    }

    const tokenId = 1;

    // 2. 调用 createAuction 方法创建拍卖
    const nftAuction = await ethers.getContractAt(
        "NftAuction",
        nftAuctionProxy.address
    );
    // ethers.getContractAt() 用于获取已部署合约的实例

    // 给代理合约授权
    await testERC721.connect(signer).setApprovalForAll(nftAuctionProxy.address, true);//为了解决合约之间的交互问题，需要给代理合约授权

    await nftAuction.createAuction(
        10,
        ethers.parseEther("0.01"),
        testERC721Address,
        tokenId
    );

    const auction = await nftAuction.auctions(0);

    console.log("创建拍卖成功：：", auction);

    // 3. 购买者参与拍卖
    // await testERC721.connect(buyer).approve(nftAuctionProxy.address, tokenId);
    // ETH参与竞价
    await nftAuction.connect(buyer).placeBid(0, 0, zeroAddress, { value: ethers.parseEther("0.01") });
    // USDC参与竞价
    // await nftAuction.connect(buyer).placeBid(0, 50, sepoliaUsdcAddress);

    // 4. 结束拍卖
    // 等待 10 s
    await new Promise((resolve) => setTimeout(resolve, 10));

    await nftAuction.connect(signer).endAuction(0);

    // 验证结果
    const auctionResult = await nftAuction.auctions(0);
    console.log("结束拍卖后读取拍卖成功：：", auctionResult);
    expect(auctionResult.highestBidder).to.equal(buyer.address);
    expect(auctionResult.highestBid).to.equal(ethers.parseEther("0.01"));

    // 验证 NFT 所有权
    const owner = await testERC721.ownerOf(tokenId);
    console.log("owner::", owner);
    expect(owner).to.equal(buyer.address);

}

main()