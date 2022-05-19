// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// import Pair contract
import "./Pair.sol";
// import SafeMath library
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
// import interface for ERC20
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract Factory {
    // this contract will implement the following functions:
    // - createPair
    // - adjustAmount
    // - getReserves
    // - addLiquidity
    // - removeLiquidity
    // - trade1for2

    // we'll use this library for performing mathematical operations
    using SafeMath for uint256;

    // initialize mapping getPair, where
    // { token1 Address => { token2 Address => address Pair}
    mapping(address => mapping(address => address)) public getPair;
    // initialize an array to store all the pairs
    address[] public allPairs;
    // initialize a counter for pairs
    uint256 public countPairs;

    // create a pair if it doesn't exist
    function createPair(address _tokenA, address _tokenB) internal returns(address pair) {
        // first, check if the two addresses are different
        require(_tokenA != _tokenB, "The addresses are equal!");

        // since pair ahould be an address we simply convert the Pair type to an address 
        pair = address(new Pair(_tokenA, _tokenB));

        // add pair to mapping
        getPair[_tokenA][_tokenB] = pair;
        // increment the number of pairs
        countPairs++;
        // add pair to the array allPairs
        allPairs.push(pair);
    }

    // adjust amount of tokens
    function adjustAmount(uint256 _amount1, uint256 _reserve1, uint256 _reserve2) 
        public pure returns(uint256 amount2) {
            // first check the _amount1 and _reserve1; they should be more than 0
        require(_amount1 > 0, "Insufficient amount of tokens");
        require(_reserve1 > 0, "Insufficient liquidity");

        // applying the formula of constant product to get the amount of reserves2
        amount2 = _amount1.mul(_reserve2).div(_reserve1);
    }

    // implement a Pairs getReserves function
    function getReserves(address _tokenA, address _tokenB) internal view
        returns(uint256 reserveA, uint256 reserveB) {
            // get pair's address from the mapping
            address pair = getPair[_tokenA][_tokenB];
            (reserveA, reserveB) = Pair(pair).getReserves();
        }

    function addLiquidity(address _tokenA, address _tokenB, uint256 _amountAToProvide, uint256 _amountBToProvide) public 
            returns(uint256 amountA, uint256 amountB) {
        // first we have to check if the pair tokenA-tokenB exist and if doesn't exist, we create it and add liquidity.
        // if it is not the first time, we should get the right amount of tokens to put
        if(getPair[_tokenA][_tokenB] == address(0)) {
            createPair(_tokenA, _tokenB);
            (amountA, amountB) = (_amountAToProvide, _amountBToProvide);
        }
        else {
            // we should find the optimal amount of tokens with adjustAmount
            // first, get the reserves of A and B
            (uint256 reserveA, uint256 reserveB) = getReserves(_tokenA, _tokenB);
            if(reserveA == 0 && reserveB == 0) {
                // if the pair exist but there's no liquidity
                (amountA, amountB) = (_amountAToProvide, _amountBToProvide);
            }
            else {
                // we get the optimal amount of tokens B
                uint256 _amountOfBOptimal = adjustAmount(_amountAToProvide, reserveA, reserveB);
                // if it's less or equal to the planned, we leave the optimal
                if(_amountOfBOptimal <= _amountBToProvide) {
                    (amountA, amountB) = (_amountAToProvide, _amountOfBOptimal);
                }
                else {
                // if it's more than planned, we calculate the optimal amount of A and leave the amount of B 
                    uint256 _amountOfAOptimal = adjustAmount(_amountBToProvide, reserveB, reserveA);
                    (amountA, amountB) = (_amountOfAOptimal, _amountBToProvide);
                }
            }
        }
        // get the address of the pair
        address pair = getPair[_tokenA][_tokenB];
        // after all that we can transfer the tokens
        // using the interface ERC20 - IERC20 in order to implement transferFrom function.
        // send tokens from msg sender to the pair
        // when deploying we need to allow the factory contract to trasfer tokens on our behalf
        // otherwise we'll get an error "transfer amount exceeds allowance"
        IERC20(_tokenA).transferFrom(msg.sender, pair, amountA);
        IERC20(_tokenB).transferFrom(msg.sender, pair, amountB);
        // and finally update reserves
        Pair(pair).updateReserves();
    }

    // here we implement the withdrawTokens function from the Pair contract
    function removeLiquidity(address _tokenA, address _tokenB, uint256 _liquidityTokens) public {
        // get pair as usual
        address pair = getPair[_tokenA][_tokenB];
        // withdraw the tokens
        Pair(pair).withdrawTokens(msg.sender, _liquidityTokens);
    }

    // swapping two tokens
    function trade2for1(uint256 _amountToken1, uint256 _minTokens2, 
            address _token1, address _token2) public {
            
        // get reserves of the two tokens
        (uint256 reserve1, uint256 reserve2) = getReserves(_token1, _token2);

        // here we implement the constant product formula
        uint256 numerator = _amountToken1.mul(reserve2);
        uint256 denominator = reserve1.add(_amountToken1);
        // this is the number of token 2
        uint256 amountToken2 = numerator.div(denominator);

        require(amountToken2 >= _minTokens2, "Not enough tokens as desired");
        // now we have to transfer tokens to the pair
        address pair = getPair[_token1][_token2];
        // transfer thr amount of A to the pair's address
        IERC20(_token1).transferFrom(msg.sender, pair, _amountToken1);
        // 0 is amount of A we want to get, second parameter is the amount of B we want to get
        // third parameter is to whom we send the tokens
        // Pair(pair).swap(uint256(0), amountToken2, msg.sender);
        Pair(pair).swap(uint256(0), amountToken2, msg.sender);
    }
}


