// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// Deckaring a modifier. 
// In general a modifier looks like this:
modifier modifierName() {
    condition to be met;
    // _ is called a merge wildcard
    // If condition is met, the function to which the 
    // modifier is attached, will be exexuted
    _; 
}



// modifier with require function
modifier modifierName() {
    // first parameter is condition
    // second parameter is expetion message 
    require(condition to be met; "The condition is not met");
    _;
}


// modifier with parameters
// using parameter _value
modifier modifierName(uint _value) {
    if(msg.value >= _value) {
        _;
    }
}

// modifier without parameters
// use construct to create a variable that will be used in the modifier
constructor Owner {
    owner = msg.sender;
}

// modifier with empty parentheses
modifier modifierName() {
    require(msg.sender == owner; "Sender is not an owner");
    _;
}

// modifier with no parentheses
modifier modifierName {
    require(msg.sender == owner; "Sender is not an owner");
    _;
}

// register only owners' addresses
contract Register {
    
    // create a variable owner - a sender's address
    address owner = msg.sender;
    // create a constructor to save the valid addresses
    constructor(address => bool) RegisteredAddresses;
    // create a modifier to check if a sender is the owner
    modifier OnlyOwner {
        require(msg.sender == owner; "Not authorised");
        _;
    }

    // create a function to register valid addresses
    // using the modifier
    function Register() public onlyOwner {
        RegisteredAddresses[msg.sender] = true;
    }
}

