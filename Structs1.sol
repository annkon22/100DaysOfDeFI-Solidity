// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Struct {
    // define a struct
    // syntax
    struct StuctName {
        type1   name1;
        type2   name2;
        type3   name3;
        ....

    }

    funciton getStruct1() public view returns(type1) {
        return StuctName.name1;
    }
}

