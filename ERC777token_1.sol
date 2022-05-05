// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC777/ERC777.sol";

contract MyERC777 is ERC777 {
    // we need to initialize ERC777 
    constructor() ERC777("AnacodingERC777", "ANC777", new address[](0)) {
        _mint(msg.sender, 100 * 10 ** 18, "", "");
    }
}

