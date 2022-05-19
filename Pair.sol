// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// import IERC20 interface
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
// import SafeMath library
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
// import Tokens contracts
import "./TokensERC20.sol";

contract Pair {
    // this contract will implement the following functions:
    // - getReserves
    // - updateReserves
    // - swap
    // - withdrawTokens
    
    // to use add, mul, div functions
    using SafeMath for uint256;

    // token references
    address public tokenA;
    address public tokenB;
    // factory address reference (not implemented yet
    address public factory;

    // initialize reserves of tokens A and B
    // reserves are the quantity of token in a pool (pair)
    uint256 private reserveTokenA;
    uint256 private reserveTokenB;

    // initialize the constructor
    constructor(address _tokenA, address _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        factory = msg.sender;
    }

    // getReserves - a getter function
    // reserves is a quantity of tokens that the pair contract has control of
    function getReserves() public view returns(uint256 reserveA, uint256 reserveB) {
        reserveA = reserveTokenA;
        reserveB = reserveTokenB;
    }

    // to get the balance we can implement a balanceOf function of IERC20 interface
    // we answer the question: what is the balance of this contract (Pair) 
    function updateReserves() public {
        // address(this) is the address of the contract itself - in this case - Pair
        uint256 BalanceA = IERC20(tokenA).balanceOf(address(this));
        uint256 BalanceB = IERC20(tokenB).balanceOf(address(this));

        // update reserves
        reserveTokenA = BalanceA;
        reserveTokenB = BalanceB;
    }

    // swap tokens
    function swap(uint256 _amountAToSwap, uint256 _amountBToSwap, address _to) public {
        // first check if the amount of tokens to swap is more than zero
        require(_amountAToSwap > 0 || _amountBToSwap > 0, "Insufficient amount to swap");
        // check if the amounts to swap are more than the reserves in the liquidity pool
        require(_amountAToSwap < reserveTokenA, "Insufficient reserves of token A");
        require(_amountBToSwap < reserveTokenB, "Insufficient reserves of token B");
    
        // if amount to swap is more than 0, make a transfer
        if(_amountAToSwap > 0) {
            IERC20(tokenA).transfer(_to, _amountAToSwap);
        }
        // same for B
        // if amount to swap is more than 0, make a transfer
        if(_amountBToSwap > 0) {
            IERC20(tokenB).transfer(_to, _amountBToSwap);
        }

        // after that update the balances (same way as in updateReserves
        uint256 BalanceA = IERC20(tokenA).balanceOf(address(this));
        uint256 BalanceB = IERC20(tokenB).balanceOf(address(this));

        // check if the balances still meet the requirements of constant 
        // product formula X * Y = K
        // we use >= because the multiplication products can deviate and not give the exact number
        require(BalanceA.mul(BalanceB) >= reserveTokenA.mul(reserveTokenB), "Constant product formula has failed");

        // if everything's alright, update the reserves
        reserveTokenA = BalanceA;
        reserveTokenB = BalanceB;
    }


    // will give the user their tokens back
    function withdrawTokens(address _to, uint256 _liquidityTokens) public {
        // how do we know how many tokens A and B to return?
        // we can use the formula of constant product to calculate the amounts

        // calculate total supply of tokens
        uint256 totalSupply = reserveTokenA.add(reserveTokenB);
        // now calculate the amount of A to withdraw
        uint256 amountAWithdraw = _liquidityTokens.mul(reserveTokenA).div(totalSupply);
        uint256 amountBWithdraw = _liquidityTokens.mul(reserveTokenB).div(totalSupply);

        // then we have to approve this amount to be transferred
        IERC20(tokenA).approve(address(this), amountAWithdraw);
        IERC20(tokenB).approve(address(this), amountBWithdraw);

        // now transfer them to the caller
        IERC20(tokenA).transferFrom(address(this), _to, amountAWithdraw);
        IERC20(tokenB).transferFrom(address(this), _to, amountBWithdraw);

        // finally, update the reserves again
        updateReserves();
    }

    function getProductConstant() public view returns (uint256) {
        return reserveTokenA.mul(reserveTokenB);
    }
}

