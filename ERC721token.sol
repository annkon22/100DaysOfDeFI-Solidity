// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";


contract MyERC721 is ERC721 {
    uint256 public counter;
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        // counter is the token ID. It should be unique
        counter = 1;
    }

    // we use an internal function _safeMint to mint an nft
    function redeemNFT() external {
        _safeMint(msg.sender, counter);
        counter++;
    }

    // function to get an URI of the specific NFT token id
    // we override this function and set a link where the NFT medatada is
    function _baseURI() internal pure override returns (string memory) {
        return "https://opensea/somenft/";
    }
}



