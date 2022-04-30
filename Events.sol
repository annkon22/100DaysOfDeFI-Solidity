// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// syntax declaring event
event eventName(parameters); 

contract Event {

    // up to 3 parameters can be indexed 
    // The indexed keyword helps you to filter the logs to find the wanted data.
    event Message(address indexed sender, string message);

    // Emiting an event
    function EmitEvent() public { 
        emit Message(msg.sender, "Hello Ethereum");
    }
}