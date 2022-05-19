// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Uniswap_part2.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract Factory {
    // pair references
    // addLiquidity
    // removeLiquidity
    // tradeAforB
    using SafeMath for uint256;
    // { tokenA Address => { tokenB Address => address Pair } }
    mapping(address => mapping(address => address)) public getPair;

    address[] public allPairs;    // to store all the pairs
    uint256 public numberOfPairs; // a counter for pairs

    function createPair(address _tokenA, address _tokenB) internal returns(address pair) {
        require(_tokenA != _tokenB, "Token addresses are equal");

        // since pair ahould be an address we simply convert the Pair type to an address 
        pair = address(new Pair(_tokenA, _tokenB));

        getPair[_tokenA][_tokenB] = pair;

        numberOfPairs++; 
        allPairs.push(pair);
    }

    function quote(uint256 _amountA, uint256 _reserveA, uint256 _reserveB) public returns(uint256 amountB) {
        require(_amountA > 0, "Insufficient funds");
        require(_reserveA > 0, "Insufficient liquidity");

        // applying the formula to get the amount of B
        // amountA is delta reserves A
        // mul and dive are functions of SafeMath library
        amountB = _amountA.mul(_reserveB).div(_reserveA);

    }

    function getReserves(address _tokenA, address _tokenB) internal returns(uint256 reserveA, uint256 reserveB) {
        address pair = getPair[_tokenA][_tokenB];
        (reserveA, reserveB) = Pair(pair).getReserves();
    }

    function addLiquidity
            (address _tokenA, address _tokenB, 
            uint256 _amountOfADesired, // amount of token A we want to provide
            uint256 _amountOfBDesired) // amount of token B we want to provide
            public returns(uint256 amountA, uint256 amountB) {

        // first we have to validate if the pair tokenA-tokenB exist
        // and if doesn't exist, we create it and add liquidity.
        // if it's the first time, they need to have a price reference from the external market

        // if it is not the first time, we shoul quote the right amount you should put

        if(getPair[_tokenA][_tokenB] == address(0)) {
            // create a pair
            createPair(_tokenA, _tokenB);
            (amountA, amountB) = (_amountOfADesired, _amountOfBDesired);
        }
        else {
            // we should find the optimal amount of tokens
            // use the function quote
            // get the reserves of A and B
            (uint256 reserveA, uint256 reserveB) = getReserves(_tokenA, _tokenB);
            if(reserveA == 0 && reserveB == 0) {
                (amountA, amountB) = (_amountOfADesired, _amountOfBDesired);
            }
            else {
                // we get the optimal amount of B
                uint256 _amountOfBOptimal = quote(_amountOfADesired, reserveA, reserveB);
                // if it's less or equal to desired, we leave the optimal
                if(_amountOfBOptimal <= _amountOfBDesired) {
                    (amountA, amountB) = (_amountOfADesired, _amountOfBOptimal);
                }
                // if it's more than desired, we calculate the optimal amount of A and leave the amount
                // of B desired
                else {
                    uint256 _amountOfAOptimal = quote(_amountOfBDesired, reserveA, reserveB);
                    (amountA, amountB) = (_amountOfAOptimal, _amountOfBDesired);
                }
            }
        }
        // transfers of tokens
        // get the address of the pair
        address pair = getPair[_tokenA][_tokenB];
        // using the interface ERC20 - IERC20 in order to implement transferFrom function.
        // send tokens from msg sender to the pair
        // when deploying we need to allow the factory contract to trasfer tokens on our behalf
        // otherwise we'll get an error "transfer amount exceeds allowance"
        IERC20(_tokenA).transferFrom(msg.sender, pair, amountA);
        IERC20(_tokenB).transferFrom(msg.sender, pair, amountB);

        // and finally update reserves
        Pair(pair).updateReserves();
        // give tokens to user providing liquidity
        // in this case we'll give a sum of number of tokens A and B
        Pair(pair).mint(msg.sender, amountA.add(amountB));
    }

    // in this example we'll just implement swap in one direction - sending tokens A to get B
    function tradeBforA(uint256 _amountOfTokenA, uint256 _minTokensBToGet, 
            address _tokenA, address _tokenB) public {
            
        // get reserves 
        (uint256 reserveA, uint256 reserveB) = getReserves(_tokenA, _tokenB);


        // here we implement constant product formula
        // _amountOfTokenA is delta A
        uint256 numerator = _amountOfTokenA.mul(reserveB);
        uint256 denominator = reserveA.add(_amountOfTokenA);
        // this is an amount of tokens B
        uint256 amountOut = numerator.div(denominator);

        require(amountOut >= _minTokensBToGet, "Not enough output as desired");
        // now we have to transfer tokens to the pair
        address pair = getPair[_tokenA][_tokenB];
        // transfer thr amount of A to the pair's address
        IERC20(_tokenA).transferFrom(msg.sender, pair, _amountOfTokenA);
        // 0 is amount of A we want to get, second parameter is the amount of B we want to get
        // third parameter is to whom we send the tokens
        Pair(pair).swap(uint256(0), amountOut, msg.sender);
    }

    function removeLiquidity(address _tokenA, address _tokenB, uint256 _liquidityTokens) public {
        address pair = getPair[_tokenA][_tokenB];
        Pair(pair).burn(msg.sender, _liquidityTokens);
    }
}