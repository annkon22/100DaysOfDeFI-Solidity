// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";

contract MyNFT is ERC721URIStorage{
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;
    mapping(string => uint8) hashes;

    constructor() ERC721("My first NFT", "ANFT") {}

    function awardItem(address recipient, string memory hash, string memory metadata) public returns(uint256) {
        require(hashes[hash] != 1);
        hashes[hash] = 1;
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, metadata);
        return newItemId;
    }
}
