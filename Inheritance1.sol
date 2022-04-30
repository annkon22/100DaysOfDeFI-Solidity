// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// single inheritance, keywords
contract A {
    // using 'virtual' keyword so derived contracts can override the function
    function foo() public virtual returns(string memory) {
        return "A";
    }
}

// Using 'is' keyword to inherit from A
contract B is A {
    // using 'override' keyword to override A.foo() function
    function foo() public virtual override returns(string memory) {
        return "B";
    }
}

// multi-level inheritance
contract Parent {
    function foo() public virtual returns(string memory) {
        return "Parent";
    }
}

contract Child1 is Parent{
    function foo() public virtual override returns(string memory) {
        return "Child1";
    }
}

contract Child2 is Child1 {
    function foo() public virtual override returns(string memory) {
        return "Child2";
    }
}

// hierarchical inheritance
// a parent contract
contract A {
    function foo() public virtual returns(string memory) {
        return "A";
    }
}

// b inherits from a
contract B is A {
    function foo() public virtual override returns(string memory) {
        return "B";
    }
}

// c inherits from a
contract C is A {
    // using 'override' keyword to override A.foo() function
    function foo() public virtual override returns(string memory) {
        return "C";
    }
}


// multiple inheritance
// a parent contract 1
contract A {
    function foo() public virtual returns(string memory) {
        return "A";
    }
}

// a parent contract 2
contract B {
    function foo() public virtual returns(string memory) {
        return "B";
    }
}

// A child contract inherits from both A and B
contract C is A, B {
        function foo() public virtual override returns(string memory) {
        return "C";
}

