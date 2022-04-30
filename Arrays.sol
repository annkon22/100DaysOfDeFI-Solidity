// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Arrays {
    // arrays are declared in a following way:

    // fixed-sized array:
    // type[ size ] ArrayName;
    uint[5] FixedSizedArray;

    // dynamic-sized array:
    // type [ ] ArrayName;
    uint[] DynamicSizedArray;
    // create dynamic memory arrays using "new" keyword
    uint[] DynamicSizedArray = new uint[](7) // 7 is size


    // Assigning values to arrays

    // fixed-sized array
    // to assign all values at once we can use
    uint FixedSizedArray[5] = [0, 1, 2, 3, 4];
    // if we are not specifying size of an array the size will be
    // the size of the initialization array
    uint FixedSizedArray[ ] = [0, 1, 2, 3, 4];
    // assigning one value
    uint FixedSizedArray[2] = 2;



    // Operations with arrays
    uint[] array;
    // 1. Add an element
    array.push(10); // adding 10 to the end of the array
    // 2. Change value
    array[1] = 10; // changing the value of the second item to 10
    // 3. Get size of an array
    uint arraySize = array.length; // initializing a variable arraySize with length method
    // 4. Remove an element
    delete array[1]; // the valut at the index 1 is reset to 0
    // 5. Pop an element (remove the last value) 
    array.pop();





}


