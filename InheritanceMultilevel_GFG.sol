// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 2. Multi-level Inheritance

contract A {
    // Declaring state variables
    string internal x;
    string a = "Geeks";
    string b = "For";

    // Defining external function
    // to return concatenated string

    function getA() external {
        x = string(abi.encodePacked(a, b));
    }
}

contract B is A {
    // Declaring state variables
    // of child contract B

    string public y;
    string c = "Geeks";

    // Defining external function to
    // return concatenated string

    function getB() external payable returns(string memory) {
        y = string(abi.encodePacked(x, c));
        return y;
    }
}

// Defining child contract C
// inheriting parent contract A

contract C is B {
    // Defining external function 
    // returning concatenated string
    // generated in child contract 
    function getC() external view returns(string memory) {
        return y;
    }
}

// Defining calling contract 
contract caller {
 
    // Creating object of child C
    C cc = new C(); 
 
    // Defining public function to
    // return final concatenated string 
    function testInheritance(
    ) public returns (
      string memory) { 
        cc.getA();
        cc.getB();
        return cc.getC(); 
    } 
}