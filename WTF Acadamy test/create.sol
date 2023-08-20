// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Pair {
    address public factory; //factory contract address
    address public tokenA;
    address public tokenB;

    constructor() payable {
        factory = msg.sender;
    }

    // called once by the factory at time of deployment
    function initialize(address _tokenA, address _tokenB) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN');
        tokenA = _tokenA;
        tokenB = _tokenB;
    }
}

contract PairFactory{
    mapping (address => mapping (address => address)) public getPair; //get Pair contract address through tokens addresses
    address[] public allPairs; // arrays that contain all Pair contracts addresses
    function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
        // create new Pair contract
        Pair pair = new Pair();
        // initialize new token pairs
        pair.initialize(tokenA, tokenB);
        pairAddr = address(pair);
        // renew Pair contract addresses arrays
        allPairs.push(pairAddr);
        // renew mapping
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }
}
