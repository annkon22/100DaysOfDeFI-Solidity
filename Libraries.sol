// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// libraries are defined using a 'library' keyword
// creating a library syntax
library LibraryName {
    // code
}

// import and deploy a library syntax
// import LibraryName from "./library_file.sol";

// // deploying a library
// LibraryName for DataType;


// deploying a library without a 'for' keyword
library LibraryConcat {
    struct coffee {
        string cupSize; 
        string coffeType;
        string add;
    }
    function Concat(string memory input1, string memory input2) 
        public pure returns(string memory) {
        return string(abi.encodePacked(input1, input2));
    }
}

contract OrderCoffee {
    // deploy the library without a 'for' keyword
    LibraryConcat.coffee order = LibraryConcat.coffee("Large", "Cappuccino", "Milk");

    function makeOrder() public view returns(string memory) {
        string memory result = LibraryConcat.Concat(order.cupSize, order.coffeType);
        result = LibraryConcat.Concat(result, order.add);
        return result;
    }
}


library Math {
    function Add(uint int1, uint int2) internal pure returns(uint) {
        uint sum = int1 + int2;
        require(sum >= int1, "uint overflow!");
        return sum;
    }
}

contract TestMath {
    using Math for uint;
    function testAdd(uint int1, uint int2) public pure returns(uint) {
        // return Math.Add(int1, int2);
        return int1.Add(int2);
    }
}