// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Loops {

    function forLoop() public pure {
        // syntax:
        // initialization: initializing a counter
        // test statement: if true the statement inside a loop is executed
        // iteration statement: incrementing counter

        for (initialization; test statement; iteration statement) {
            statements
        }
        // example
        for (uint i = 0; i < 5; i ++) {
            // do stuff
            continue;
        } 
    }

    function whileLoop() public pure {
        //syntax
        // condition: if condition is true the statements are executed
        while (condition) {
            statements

        // example
        while (i < 10) {
            // do stuff
            i ++;
            }
        }
    }

    function dowhileLoop() public pure {
        // similar to a while loop with one difference that 
        // the condition is checked afterwards, so the statement is 
        // executed at least one if the condition is False
        // syntax
        // condition: if condition is true the statements are executed
        do {
            statements
        } while (condition); 
    }

    function ContinueBreakLoop() public pure {
        // continue and break are statements for handling loops
        // continue: skip some specific iteration in loop
        // break: terminate the iteration 
        for (uint i = 0; i < 10; i ++) {
            // do stuff
            if(i == 5) {
                continue;
            }
            if(i == 7) {
                break;
            }
        } 
    }
}


