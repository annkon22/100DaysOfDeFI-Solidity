// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// Syntax
// define enums
// enum EnumName {
//     // predefined values or enums
//     Elem_1, Elem_2, Elem_3 ... Elem_n
// }

// // create enumerator
// enum CoffeeTypes {ESPRESSO, CAPUCCINO, LATTE, MACCHIATO}

// // declare a variable enumerator
// CoffeeTypes coffee;


contract GetCoffee {
    // create enumerator coffee types
    enum CoffeeTypes {ESPRESSO, CAPUCCINO, LATTE, MACCHIATO}

    // declare a variable enumerator
    CoffeeTypes coffee;
    // declare a constant variable coffee
    CoffeeTypes constant DefaultCoffee = CoffeeTypes.ESPRESSO;

    // set type of coffee you want (as an integer)
    function setCoffee(CoffeeTypes _coffee) public {
        coffee = _coffee;
    }

    // get an ordered coffee
    function get_CupOfCoffee() public view returns(CoffeeTypes) {
        return coffee;
    }
    
    // get a coffee set by default: Espresso
    function get_DefaultCupOfCoffee() public pure returns(CoffeeTypes) {
        return DefaultCoffee;
    }
}

