// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./MintNFT.sol";

contract SaleNFT{
    MintNFT public mintNFTContract;

    mapping (uint => uint) public tokenPrices;

    constructor(address _mintNFTAddress) {
        mintNFTContract = MintNFT(_mintNFTAddress);
    }

    function setForSale(uint _tokenId, uint _price) public {
        require(mintNFTContract.ownerOf(_tokenId) == msg.sender, "Caller is not token owner.");
        require(_price > 0, "Price is zero or lower.");
        require(tokenPrices[_tokenId] == 0, "Already on sale.");
        require(mintNFTContract.isApprovedForAll(msg.sender, address(this)), "Not approved.");

        tokenPrices[_tokenId] = _price;
    }

    function purchase(uint _tokenId) public payable  {
        address nftOwner = mintNFTContract.ownerOf(_tokenId);
        require(mintNFTContract.ownerOf(_tokenId) != msg.sender, "Caller is token owner.");
        require(tokenPrices[_tokenId] > 0, "Not sale.");
        require(tokenPrices[_tokenId] <= msg.value, "Caller sent lower than price.");

        payable(mintNFTContract.ownerOf(_tokenId)).transfer(msg.value);

        mintNFTContract.safeTransferFrom(nftOwner, msg.sender, _tokenId);

        tokenPrices[_tokenId] = 0;
    }
}