// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// identify states example
// can be defined as a constant value
bytes32 constant START = "start";
bytes32 constant IN_PROGRESS = "inProgress";
bytes32 constant ENDED = "ended";

bytes32 state;
// setting up the state machine is usually done in the constructor
constructor State(bytes32 _state) {
    state = _state;
}

// or as an enumerated list
enum States {
        Start,
        InProgress,
        Ended
    }

// declare a States variable
States public state = States.InProgress;
// modifer example
modifier atState(State _state) {
    require(state == _state)
}

// this function is executed only at state InProgress
function foo() public atState(States.InProgress) {
        // code
    }