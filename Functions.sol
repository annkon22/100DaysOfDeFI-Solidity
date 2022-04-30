// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Funcitons {
    // data
    // set data
    // set computed data
    // set multiplier

    uint256 public data;
    uint256 public multiplier;
    address public owner;

    constructor(uint256 _initialValue, uint256 _initialMultiplier) {
        data = _initialValue;
        multiplier = _initialMultiplier;
        owner = msg.sender;
    }
    
    function setData(uint256 _newData) public onlyOwner returns(bool) {
        data = _newData;
        return true;
    }

    function setMultiplier(uint256 _multiplier) external onlyOwner returns(bool) {
        multiplier = _multiplier;
        return true;
    }

    function setComputedData(uint256 _newData) external onlyOwner returns(bool){
        uint256 dataComputed = computeData(_newData);
        return setData(dataComputed);
    }

    function computeData(uint256 _someData) internal view returns(uint256) {
        return _someData * multiplier;
    }

    modifier onlyOwner {
        require (msg.sender == owner,  "Invalid owner");
        _;  // placeholder for a function

    }
}