// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract CallWithSelector {
    // call function with function selector
    function callInt(address contractAddress, bytes4 selector) public view returns (uint result) {
        bytes memory callIntABI = abi.encodeWithSelector(selector);
        (bool success, bytes memory returnedData) = address(contractAddress).staticcall(callIntABI);
        require(success);

        return abi.decode(returnedData, (uint));
    }
}

contract ABIEncodeAndDecode{
    uint public x = 10;
    address public addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    string public name = "Sam Altman";
    uint[3] public array = [1, 2, 3];

    function encode() public view returns (bytes memory result) {
        result = abi.encode(x, addr, name, array);
    }

    function encodePacked() public view returns (bytes memory result) {
        result = abi.encodePacked(x, addr, name, array);
    }

    function encodeWithSignature() public view returns (bytes memory result) {
        result = abi.encodeWithSignature("foo(uint256,address,string,uint256[3])", x, addr, name, array);
    }

    function encodeWithSelector() public view returns (bytes memory result) {
        result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[3])")), x, addr, name, array);
    }

    function decode(bytes memory data) public pure returns (uint dx, address daddr, string memory dname, uint[3] memory darray) {
        (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[3]));
    }

    function getStaticIntSelector() public pure returns (bytes4 result) {
        result = bytes4(keccak256("getStaticInt()"));
    } 

    function getStaticInt() public pure returns (uint result) {
        return 1288;
    }
}