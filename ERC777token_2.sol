// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC777/ERC777.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC777/IERC777Recipient.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC777/IERC777.sol";



// this contract will receive tokens. It will act as an Operator
contract SubscriptionContract is IERC777Recipient{

    IERC777 public tokenInstance;

    constructor(address _tokenInstance) {
        tokenInstance = IERC777(_tokenInstance);
        // we pass the same address that is in ERC777.sol line 32
        IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24).setInterfaceImplementer(address(this),
                        keccak256("ERC777TokensRecipient"), address(this));
    }

    // we have to implement this function that is in the IERC777Recipient interface
    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) override external {
        // perform any operation when we receive tokens
        // for example, reject undesired tokens
        // or revert a transaction
    }

    function chargeFee() external {
        tokenInstance.operatorSend(address(msg.sender), address(this), 10 * 10**18, "", "");
    }
}