// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintToken is ERC1155, Ownable {
    string public name;
    string public symbol;

    mapping(uint => string) metadataUris;

    constructor(string memory _name, string memory _symbol) ERC1155("") Ownable(msg.sender){
        name = _name;
        symbol = _symbol;
    }

    function mintToken(uint _tokenId, uint _amount) public {
        _mint(msg.sender, _tokenId, _amount, "");
    }

    function setUri(uint _tokenId, string memory _metadataUri) public {
        metadataUris[_tokenId] = _metadataUri;
    }

    function uri(uint _tokenId) public override  view returns(string memory) {
        return metadataUris[_tokenId];
    }
}