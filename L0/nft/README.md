# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

## 目录

```

├── hardhat.config.js      # Hardhat 配置文件，定义编译选项、网络配置等
├── package.json           # 项目依赖配置文件，记录项目依赖包信息
├── package-lock.json      # 依赖包版本锁定文件，确保依赖版本一致性
├── README.md             # 项目说明文档
├── .gitignore            # Git 忽略文件配置
│
├── contracts/            # 智能合约源代码目录
│   └── NftAuction.sol    # NFT 拍卖合约源代码
│
├── scripts/              # 部署脚本目录
│   └── deploy.js         # 合约部署脚本
│
├── test/                 # 测试文件目录
│   └── NftAuction.js     # NFT 拍卖合约测试文件
│
├── artifacts/            # 编译输出目录
│   ├── build-info/       # 编译信息，包含源代码哈希等
│   └── contracts/        # 编译后的合约文件
│       └── NftAuction.sol/  # NFT 合约的 ABI、字节码等
│
├── cache/               # Hardhat 缓存目录，存储编译缓存
│
├── node_modules/        # 项目依赖包安装目录
│
├── deploy/             # 部署记录目录（由 hardhat-deploy 插件管理）
│
├── .states/            # 部署状态目录（由 hardhat-deploy 插件管理）
│
└── ignition/           # Hardhat Ignition 部署模块目录

```