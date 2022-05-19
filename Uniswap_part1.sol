// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
   constructor() ERC20("TokenA", "TKA") {
      _mint(msg.sender, 1000 * 10**18); 
   }

}



contract TokenB is ERC20 {
   constructor() ERC20("TokenB", "TKB") {
      _mint(msg.sender, 1000 * 10**18);
   }

}


   contract LPToken is ERC20 {
      constructor() ERC20("LPToken", "LPT") {}

      // modifier onlyFactory {
      //    require(factoryAddress == msg.sender, "invalid factory");
      //    _;
      // }

      function mint(address account, uint256 amount) public {
         _mint(account, amount);
      }

      function burn(address account, uint256 amount) public {
         _burn(account, amount);
      }


}