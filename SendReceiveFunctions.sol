// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SendEther {
    // send ether via tranfer
    // returns status as a boolean
    function ByTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    // send ether via send
    funciton BySend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
    }

    // sent ether via call. Most recommended option
    // returns atatus as a boolean and data
    function ByCall(address payable _to) public payable {
        (bool sent, memory data) = _to.call{value: msg.value}("")
        require(sent; "Ether not sent!")
    }
}

contract ReceiveEther {
    // function to receive Ether
    receive() external payable {}
    // fallback functions
    // is executed if msg.data is not empty
    // or a receive() functions doesn't exist
    fallback() external payable {}
}
