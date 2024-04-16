// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintNFT is ERC721Enumerable, Ownable {
    mapping (uint => string) public metadataUris;

    constructor(address initialOwner) ERC721("kdh NFT", "kdh") Ownable(initialOwner) {}

    function mintNFT() public {
        uint tokenId = totalSupply() + 1;

        _mint(msg.sender, tokenId);
    }

    function setTokenUri(uint _tokenId, string memory _metadataUri) public {
        metadataUris[_tokenId] = _metadataUri;
    }

    function tokenURI(uint _tokenId) public view override returns (string memory) {
        return metadataUris[_tokenId];
    }
}