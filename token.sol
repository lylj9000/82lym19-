下面是一个简单的Solidity智能合约示例，用于授权A地址将B地址中的USDT转账给C地址：

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.0/contracts/token/ERC20/IERC20.sol";

contract USDTAuthorization {
    address public owner;
    address public usdtAddress;  // USDT合约地址
    mapping(address => bool) public authorizedUsers;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyAuthorized() {
        require(authorizedUsers[msg.sender], "Not authorized");
        _;
    }

    event Authorization(address indexed user);
    event Revocation(address indexed user);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor(address _usdtAddress) {
        owner = msg.sender;
        usdtAddress = _usdtAddress;
    }

    function authorizeUser(address user) external onlyOwner {
        authorizedUsers[user] = true;
        emit Authorization(user);
    }

    function revokeAuthorization(address user) external onlyOwner {
        authorizedUsers[user] = false;
        emit Revocation(user);
    }

    function transferUSDT(address from, address to, uint256 amount) external onlyAuthorized {
        require(from != address(0), "Invalid sender address");
        require(to != address(0), "Invalid recipient address");
        require(amount > 0, "Invalid transfer amount");

        IERC20 usdt = IERC20(usdtAddress);
        require(usdt.transferFrom(from, to, amount), "USDT transfer failed");
        emit Transfer(from, to, amount);
    }
}

在这个示例中，A地址（即合约部署者）可以通过调用authorizeUser函数来授权其他地址，然后这些已授权的地址可以调用transferUSDT函数，从B地址向C地址转账USDT。请确保在使用前测试和审查这个合约，以确保其安全性和正确性