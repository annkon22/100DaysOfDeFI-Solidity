// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract BasicToken {
    // we can use mapping to use addresses and balances
    // address => balance
    mapping(address => uint256) public balances;

    // define state variables 
    string tokenName;
    address owner;
    uint256 totalTokens;

    constructor(string memory _tokenName, uint256 _totalTokens) {
        // token name will be the name of our tokens
        tokenName = _tokenName;
        // total amount of tokens
        totalTokens = _totalTokens;
        // owner is a msg.sender - a person who is currently connecting with a contract
        owner = msg.sender;
        // assign total supply of token to the creator
        balances[owner] = totalTokens;
        
    }

    // transfer tokens to another address
    function transfer(address _to, uint256 _amount) external {
        // we should check if the owner has enough tokens to make a transaction
        require(balances[owner] >= _amount, "Insufficient funds");
        // if the condition is true, update the balances of owner and recepient
        balances[owner] = balances[owner] - _amount;
        balances[_to] = balances[_to] + _amount;
    }

    // return the balance of a specific address
    function balanceOf(address _owner) public view returns(uint256) {
        return balances[_owner];
    }

    // just return thr total amount of tokens
    function totalSupply() public view returns(uint256) {
        return totalTokens;
    }
}

