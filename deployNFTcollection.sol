// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";

contract NFTCollection is ERC721 {
    uint256 private _tokenIds;

    constructor() ERC721("Name", "Symbol") {}

    // function to create an NFT
    function mint() public returns(uint256) {
        _tokenIds += 1;
        _mint(msg.sender, _tokenIds);
        return _tokenIds;
    }

    // here we include the CID of the json folder
    function tokenURI(uint256 _tokenId) override public pure returns(string memory) {
        // here sfter https://gateway.pinata.cloud/ipfs/ goes CID of the json folder and then the image's name without a number
        return string(abi.encodePacked("https://gateway.pinata.cloud/ipfs/QmYKRLhjYqhbw8ndLJTEWZn7fbzPSqBNviPZxz7FM7JqvN/image_", 
                Strings.toString(_tokenId), ".json"));
    }
}
