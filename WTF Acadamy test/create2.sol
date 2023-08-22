// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import "./create.sol";

contract PairFactory2{
    // get Pair contract address through token addresses
    mapping (address => mapping (address => address)) public getPair;
    // store all Pair contracts addresses in dynamic arrays
    address[] public allPairs;
    
    function createPair2(address tokenA, address tokenB) external returns (address pairAddr) {
        // avoid tokenA and tokenB being identical
        require(tokenA != tokenB, 'IDENTICAL_ADDRESSES');
        // sort tokenA and tokenB in order of size
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        // calculate salt with tokenA and tokenB addresses
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // deploy new Pair contract with create2 code
        Pair pair = new Pair{salt: salt}();
        // initialize new tokens pairs
        pair.initialize(tokenA, tokenB);
        pairAddr = address(pair);
        // renew Pair addresses arrays
        allPairs.push(pairAddr);
        // renew mapping
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }

    // calculate Pair address in advance
    function calculateAddr(address tokenA, address tokenB) public view returns (address predictedAddress) {
        // avoid tokenA and tokenB being identical
        require(tokenA != tokenB, 'IDENTICAL_ADDRESSES');
        // sort tokenA and tokenB in order of size
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        // calculate salt with tokenA and tokenB addresses
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // calculate Pair address
        predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xFF),
            address(this),
            salt,
            keccak256(type(Pair).creationCode) // keccak256 hash of the bytecode of the Pair contracr to be created after
        )))));
    }
}