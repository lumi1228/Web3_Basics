// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract NftAuction is Initializable {
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

        // 参与竞价的资产类型 0x 地址表示eth，其他地址表示erc20
        // 0x0000000000000000000000000000000000000000 表示eth
        address tokenAddress;
    }

    // 状态变量
    mapping(uint256 => Auction) public auctions;

    // 下一个拍卖ID
    uint256 public nextAuctionId;

    // 管理员地址
    address public admin;
    
    //  AggregatorV3Interface internal priceETHFeed;
    mapping(address => AggregatorV3Interface) public priceFeeds;
    
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


    function setPriceFeed(
        address tokenAddress,
        address _priceFeed
    ) public {
        priceFeeds[tokenAddress] = AggregatorV3Interface(_priceFeed);
    }


    // 获取 Chainlink 预言机提供的代币价格数据 
    // ETH -> USD => 1766 7512 1800 => 1766.75121800
    // USDC -> USD => 9999 4000 => 0.99994000
    function getChainlinkDataFeedLatestAnswer(
        address tokenAddress
    ) public view returns (int256) {
        AggregatorV3Interface priceFeed = priceFeeds[tokenAddress];
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return answer;
    }

    // 创建拍卖
    function createAuction(uint256 duration, uint256 startPrice, address _ntfAddress, uint256 tokenId) public{
        // 只有管理员可以创建拍卖
        require(msg.sender == admin, "Only admin can create auction");

        // 检查参数
        require(duration >= 10, "Duration must be at least 1 minute");
        require(startPrice > 0, "Start price must be greater than zero");

         // 转移NFT到合约
        IERC721(_ntfAddress).approve(address(this), tokenId);
        // IERC721(_ntfAddress).transferFrom(msg.sender, address(this), tokenId);

        auctions[nextAuctionId] = Auction({
            seller: msg.sender,
            duration: duration,
            startPrice: startPrice,
            ended: false,
            highestBidder: address(0),
            highestBid: 0,
            startTime: block.timestamp,
            nftContract: _ntfAddress,
            tokenId: tokenId,
            tokenAddress: address(0)
        });
        nextAuctionId++;

    }
    // 卖家参与买单
    // TODO: ERC20 也能参加
    function placeBid(uint256 _auctionID,uint256 amount,address _tokenAddress) external payable{
        Auction storage auction = auctions[_auctionID];
        // ===========判断当前拍卖是否结束===========
        require(
            !auction.ended &&
                auction.startTime + auction.duration > block.timestamp,
            "Auction has ended"
        );
        

        // ===========判断出价是否大于当前最高出价===========
        // 统一的价值尺度
        // ETH 是 ？ 美金
        // 1个 USDC 是 ？ 美金

        uint payValue;
        if (_tokenAddress != address(0)) {
            // 处理 ERC20
            // 检查是否是 ERC20 资产
            payValue = amount * uint(getChainlinkDataFeedLatestAnswer(_tokenAddress));
        } else {
            // 处理 ETH
            amount = msg.value;

            payValue = amount * uint(getChainlinkDataFeedLatestAnswer(address(0)));
        }
         uint startPriceValue = auction.startPrice *
            uint(getChainlinkDataFeedLatestAnswer(auction.tokenAddress));

        uint highestBidValue = auction.highestBid *
            uint(getChainlinkDataFeedLatestAnswer(auction.tokenAddress));

        require(
            payValue >= startPriceValue && payValue > highestBidValue,
            "Bid must be higher than the current highest bid"
        );
         // ===========返回之前的最高出价者===========
        // 转移 ERC20 到合约
        IERC20(_tokenAddress).transferFrom(msg.sender, address(this), amount);
        if (auction.tokenAddress == address(0)) {
            // 处理 ETH
            payable(auction.highestBidder).transfer(auction.highestBid);
        }else{
            // 处理 ERC20
            // 退回之前的ERC20
            IERC20(auction.tokenAddress).transfer(
                auction.highestBidder,
                auction.highestBid
            );
        }

        
        // ===========更新最高出价者===========
        auction.tokenAddress = _tokenAddress;
        auction.highestBidder = msg.sender;
        auction.highestBid = amount;
    }

    // 结束拍卖
    function endAuction(uint256 _auctionID) external{
        Auction storage auction = auctions[_auctionID];


        // 判断当前拍卖是否结束
        require( !auction.ended &&
                (auction.startTime + auction.duration) <= block.timestamp,'Auction has not ended');
        // block.timestamp 单位是s 

        // 转移NFT给出价最高者
        // IERC721(auction.nftContract).safeTransferFrom((address(this)), auction.highestBidder, auction.tokenId);
        IERC721(auction.nftContract).safeTransferFrom(
            admin,
            auction.highestBidder,
            auction.tokenId
        );

        // 转移剩余的资金到卖家
        // payable(address(this)).transfer(address(this).balance);
        auction.ended = true;
    }
    

}
