// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace {
    ERC20 public token; // ERC20 代币合约地址
    ERC721 public nft; // NFT 合约地址

    struct Listing {
        address seller; // 出售者地址
        uint256 tokenId; // NFT 的标识符
        uint256 price; // NFT 的价格（以代币计价）
        bool active; // 是否处于上架状态
    }

    mapping(uint256 => Listing) public listings; // NFT 上架列表，tokenId => Listing

    event NFTListed(address seller, uint256 tokenId, uint256 price);
    event NFTSold(address buyer, address seller, uint256 tokenId, uint256 price);

    constructor(address _tokenAddress, address _nftAddress) {
        token = ERC20(_tokenAddress);
        nft = ERC721(_nftAddress);
    }

    /**
     * @dev 将 NFT 上架出售
     * @param tokenId NFT 的标识符
     * @param price NFT 的价格（以代币计价）
     */
    function listNFT(uint256 tokenId, uint256 price) external {
        require(nft.ownerOf(tokenId) == msg.sender, "You are not the owner of this NFT");

        listings[tokenId] = Listing({
            seller: msg.sender,
            tokenId: tokenId,
            price: price,
            active: true
        });

        emit NFTListed(msg.sender, tokenId, price);
    }

    /**
     * @dev 购买 NFT
     * @param tokenId NFT 的标识符
     */
    function buyNFT(uint256 tokenId) external {
        require(listings[tokenId].active, "This NFT is not listed for sale");

        Listing memory listing = listings[tokenId];
        uint256 price = listing.price;

        // 转账代币给卖家
        token.transferFrom(msg.sender, listing.seller, price);

        // 转移 NFT 给买家
        nft.transferFrom(listing.seller, msg.sender, tokenId);

        // 标记 NFT 已售出
        listings[tokenId].active = false;

        emit NFTSold(msg.sender, listing.seller, tokenId, price);
    }
}
