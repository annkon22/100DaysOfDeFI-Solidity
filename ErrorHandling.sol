// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ErrorHandling {

    uint num = 10;

    // used to check for internal errors
    // the condition inside assert should be true.
    function testAssert() public view {
        // first set a true condition
        // assert(num == 10);
        // then set a false condition
        assert(num == 13);
    }

    function testRequire(uint _num) public pure{
        // this function requires an input _num to be less than 10
        // in other case, the transaction is reverted
        require(_num < 10, "Number is not valid.");
    }

    function testRevert(uint _num) public pure {
        // in this case we set a condition with 'if'
        // if an input is less than 10, the 
        // transaction is reverted
        if(_num < 10) {
            revert("Number is not valid");
        }
    }
}
