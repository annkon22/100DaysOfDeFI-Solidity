// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// this contract is to test try/catch statement
contract Test {
    // we will test the address to be valid
    address public owner;

    constructor(address _owner) {
        // the address cannot be 0 or 0x0000000000000000000000000000000000000000
        // we check it with a require function
        require(_owner != address(0), "Owner cannot be 0");
        // the address cannot be 1 or 0x0000000000000000000000000000000000000001
        // we check it with an assert function
        assert(_owner != address(1));
        // if two tests are passed the we declare a variable owner
        owner = _owner;
    }

    // this function will be tested
    function TestFunction(uint _num) public pure returns(string memory) {
        require(_num > 10, "A number should be greater than 10");
        return "A TestFunction passed the test";
    }
}

// this contract implements try/catch statements
contract TryCatchTest {
    // create logs variables
    event Log(string message);
    event LogBytes(bytes data);

    // 1. an external function call
    // create an instance of a class Test
    Test public test;
    constructor() {
        test = new Test(msg.sender);
    } 

    function CatchExternalCall(uint _num) public {
        // pass an int when executing.
        try test.TestFunction(_num) returns(string memory result){
            emit Log(result);
        }
        catch {
            emit Log("External function failed");
        }
    }

    // 2. a contract creation 
    function CatchContractCreation(address _owner) public {
        // try creating a contract instance passing an address
        try new Test(_owner) returns(Test test){
            emit Log("Class Test created successfully");
        }
        // catches a require function
        catch Error(string memory reason) {
            emit Log(reason);
        }
        // catches an assert function
        catch (bytes memory reason) {
            emit LogBytes(reason);
        }
    }
}   