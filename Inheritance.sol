// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

abstract contract ContractD {
    function WhoAreYou() public virtual returns(string memory);
}

contract ContractC {
    function WhoAmI() public virtual view returns(string memory) {
        return "Contract C";
    }
}

contract ContractB {
    function WhoAmI() public virtual view returns(string memory) {
        return "Contract B";
    }

    function WhoAmIInternal() internal pure returns(string memory) {
        return "Contract B";
    }

}

contract ContractA is ContractB,  ContractC, ContractD {


    enum Type {None, ContractBType, ContractCType}

    Type contractType;

    constructor(Type initialType) {
        contractType = initialType;
    }

    function WhoAmI() override(ContractB, ContractC) public view returns(string memory) {
        if(contractType == Type.ContractBType) {
            return ContractB.WhoAmI();
        }

         if(contractType == Type.ContractCType) {
            return ContractC.WhoAmI();
        }

        return "Contract A";
    }

    function ChangeType(Type newType) external {
        contractType = newType;
    }

    function WhoAmIExternal() external pure returns(string memory) {
        return WhoAmIInternal();
    }

    function WhoAreYou() public override pure returns(string memory) {
        return "A person";
    }

}

