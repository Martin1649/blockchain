// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFTMarketplace {
    struct NFT {
        address owner;
        uint256 price;
    }

    mapping(uint256 => NFT) public nfts;

    ERC721 public nftContract;
    IERC20 public tokenContract;

    constructor(address _nftAddress, address _tokenAddress) {
        nftContract = ERC721(_nftAddress);
        tokenContract = IERC20(_tokenAddress);
    }

    function listNFT(uint256 tokenId, uint256 price) external {
        require(nftContract.ownerOf(tokenId) == msg.sender, "Only NFT owner can list");

        nfts[tokenId] = NFT(msg.sender, price);
    }

    function buyNFT(uint256 tokenId) external {
        NFT memory nft = nfts[tokenId];
        require(nft.owner != address(0), "NFT not listed");

        uint256 price = nft.price;
        require(tokenContract.balanceOf(msg.sender) >= price, "Insufficient token balance");

        nftContract.transferFrom(nft.owner, msg.sender, tokenId);
        tokenContract.transferFrom(msg.sender, nft.owner, price);

        delete nfts[tokenId];
    }
}
