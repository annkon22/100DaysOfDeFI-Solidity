// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Structs {
    struct User {
        uint8 age;
        string name;
    }

    mapping(address => User) public users;
    
    function register(uint8 age, string memory name) external returns(bool) {
        users[msg.sender] = User(age, name);
        return true;
    }
}