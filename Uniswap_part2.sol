// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "./Uniswap_part1.sol";


contract Pair {
    // we have to implement the following 
    // references
    // reserves
    // getReserves
    // updateReserves
    // swap
    using SafeMath for uint256;

    // token references
    address public tokenA;
    address public tokenB;
    // Factory contract will have a function createPair
    // so it's important to have a reference to the factory
    address public factory; // 

    // to store the quantity of token A
    uint256 private reserveTokenA; // holds number of the reserves of token A
    uint256 private reserveTokenB; // holds number of the reserves of token B
    // instance of Liquidity provider token
    LPToken lptoken;

    constructor(address _tokenA, address _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        factory = msg.sender;
        lptoken = LPToken(0xC3Ba5050Ec45990f76474163c5bA673c244aaECA); // copy the address of the lptoken contract
    }


    // getReserves - a getter function
    // reserves is a quantity of tokens that the pair contract has control of
    function getReserves() public view returns(uint256 reserveA, uint256 reserveB) {
        reserveA = reserveTokenA;
        reserveB = reserveTokenB;

    }


    // 
    // to know the balance we can implement a balanceOf function of IERC20 interface
    // what is the balance of this contract (Pair) 
    function updateReserves() public onlyFactory {
        uint256 balanceOfTokenA = IERC20(tokenA).balanceOf(address(this));
        uint256 balanceOfTokenB = IERC20(tokenB).balanceOf(address(this));

        reserveTokenA = balanceOfTokenA;
        reserveTokenB = balanceOfTokenB;
    }

    // msg.sender is the address of the contract caller
    // address(this) is the address of the contract itself
    modifier onlyFactory {
        require(msg.sender == factory, "Only factory can update");
        _;
    }


    // swap function
    function swap(uint256 _amountTokenAOut, uint256 _amountTokenBOut, address _to) public {
        require(_amountTokenAOut > 0 || _amountTokenBOut > 0, "Insufficient output amount");
        require(_amountTokenAOut < reserveTokenA, "Insufficient reserve A");
        require(_amountTokenBOut < reserveTokenB, "Insufficient reserve B");

        if(_amountTokenAOut > 0) {
            // do a transfer
            IERC20(tokenA).transfer(_to, _amountTokenAOut);
        }

        if(_amountTokenBOut > 0) {
            // transfer
            IERC20(tokenB).transfer(_to, _amountTokenBOut);
        }
        // update balances
        // get balances of tokens A and B
        uint256 balanceTokenA = IERC20(tokenA).balanceOf(address(this));
        uint256 balanceTokenB = IERC20(tokenB).balanceOf(address(this));
        // verify constant  product formula
        require(balanceTokenA.mul(balanceTokenB) >= reserveTokenA.mul(reserveTokenB), "K constant failed");
        
        reserveTokenA = balanceTokenA;
        reserveTokenB = balanceTokenB;
    }

    function getProductConstant() public view returns(uint256) {
        return reserveTokenA.mul(reserveTokenB);
    }

    function mint(address _to, uint256 _amount) public {
        lptoken.mint(_to, _amount);
    }
    // will give the user their lp tokens
    function burn(address _to, uint256 _liquidity) public {
        // how do we know how many tokens A and B I need to return
        uint256 totalSupply = reserveTokenA.add(reserveTokenB);
        uint256 amountAToTransfer = _liquidity.mul(reserveTokenA).div(totalSupply);
        uint256 amountBToTransfer = _liquidity.mul(reserveTokenB).div(totalSupply);

        IERC20(tokenA).approve(address(this), amountAToTransfer);
        IERC20(tokenB).approve(address(this), amountBToTransfer);

        IERC20(tokenA).transferFrom(address(this), _to, amountAToTransfer);
        IERC20(tokenB).transferFrom(address(this), _to, amountBToTransfer);

        lptoken.burn(_to, _liquidity);

        updateReserves();
    }

}