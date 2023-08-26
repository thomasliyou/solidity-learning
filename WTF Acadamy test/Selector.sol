// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Selector {
    // return msg.data
    event Log(bytes data);

    function testSelector(address) external {
        emit Log(msg.data);
    }
    
    // get getSelector() selector
    // "testSelector(address)": 0xe6010cb7
    function getSelector() external pure returns (bytes4 selector) {
        selector = bytes4(keccak256("testSelector(address)"));
    }
}

contract CallWithSelector {
    function callWithSelector(address addr, address testSelectorAddr) external returns (bool, bytes memory) {
        (bool success, bytes memory data) = addr.call(abi.encodeWithSelector(0xe6010cb7, testSelectorAddr));
        return(success, data);
    }
}