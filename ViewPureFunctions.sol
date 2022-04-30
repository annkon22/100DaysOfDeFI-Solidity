// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ViewAndPure {
    uint public x = 1;

    function viewFunctions(uint y) view (returns uint) {
        // sum x and y. doesn't modify x but only reads it
        return x + y;
    }
    
    function pureFunctions(uint y, uint z) pure returns(uint) {
        // sum y and z. doesn't modify nor accesses x
        return y + z;
    }
}