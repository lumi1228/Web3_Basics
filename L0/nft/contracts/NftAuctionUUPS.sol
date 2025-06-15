// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol"; //导入包 UUPSUpgradeable

contract NftAuctionUUPS is Initializable, UUPSUpgradeable { //继承 UUPSUpgradeable
    // 结构体
    struct Auction{
        // 卖家地址
        address seller;

        // 拍卖持续时间
        uint duration;

        // 起拍价格 
        uint256 startPrice;
        // 开始时间
        uint256 startTime;

        // 是否结束
        bool ended;
        // 最高出价者
        address highestBidder;
        // 最高出价
        uint256 highestBid;

        // NFT合约地址
        address nftContract;

        // NFT ID
        uint256 tokenId;
    }

    // 状态变量
    mapping(uint256 => Auction) public auctions;

    // 下一个拍卖ID
    uint256 public nextAuctionId;

    // 管理员地址
    address public admin;

    // constructor() {
    //     admin = msg.sender;
    // }
    // 部署合约
    // 构造函数自动执行
    // 初始化完成

    // ----------------------------
    function initialize() initializer public  {
        admin = msg.sender;
    }
    // 可升级合约：
    // 部署代理合约
    // 部署实现合约
    // 手动调用 initialize()
    // 初始化完成


    // 创建拍卖
    function createAuction(uint256 duration, uint256 startPrice, address _ntfAddredd, uint256 tokenId) public{
        // 只有管理员可以创建拍卖
        require(msg.sender == admin, "Only admin can create auction");

        // 检查参数
        require(duration > 1000*60, "Duration must be at least 1 minute");
        require(startPrice > 0, "Start price must be greater than zero");

        auctions[nextAuctionId] = Auction({
            seller: msg.sender,
            duration: duration,
            startPrice: startPrice,
            ended: false,
            highestBidder: address(0),
            highestBid: 0,
            startTime: block.timestamp,
            nftContract: _ntfAddredd,
            tokenId: tokenId
        });
        nextAuctionId++;

    }
    // 卖家参与买单
    function placeBid(uint256 _auctionID) external payable{
        Auction storage auction = auctions[_auctionID];
        // 判断当前拍卖是否结束
        require(!auction.ended  , "Auction has ended");
        require( auction.startTime + auction.duration > block.timestamp , "Auction has not started yet");

        // 判断出价是否高于当前最高出价
        require(msg.value > auction.highestBid && msg.value > auction.startPrice," Bid must be higher than current highest bid and start price");
        
        // 返回之前的最高出价者
        if(auction.highestBidder != address(0)){
            payable(auction.highestBidder).transfer(auction.highestBid);
        }
        // 更新最高出价者
        auction.highestBidder = msg.sender;
        auction.highestBid = msg.value;
    }
    
    function _authorizeUpgrade(address newImplementation) internal override view{
        // 只有管理员可以升级合约
        require(msg.sender == admin, "must");
    }
}
