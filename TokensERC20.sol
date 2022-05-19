// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// import OpenZeppeling implementation of erc20 standard
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

// create token A
contract TokenA is ERC20 {
   constructor() ERC20("tokenA", "tA") {
       // when deploying the contract, mint 100 tokens 
       // msg.sender is the address of the contract caller
      _mint(msg.sender, 100000 * 10**18); 
   }

}

contract TokenB is ERC20 {
   constructor() ERC20("tokenB", "tB") {
       // when deploying the contract, mint 100 tokens
      _mint(msg.sender, 100000 * 10**18);
   }

}

