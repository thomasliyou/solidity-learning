// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract NoOdd {
    constructor(uint256 a) {
        require(a != 0, "invalid number");
        assert(a != 1);
    }

    function noOdd(uint256 b) external pure returns (bool success) {
        // revert if argument is odd
        require(b % 2 == 0, "argument cannot be odd");
        return true;
    }
}

contract TryCatch {
    event SuccessEvent();
    
    event CatchEvent(string message);
    event CatchByte(bytes data);

    // create a new "NoOdd" contract variable
    NoOdd even;
    constructor() {
        even = new NoOdd(3);
    }

    // Use try-catch dealing with external function call exceptions
    function execute(uint256 amount) external returns (bool success) {
        try even.noOdd(amount) returns (bool _success) {
            // if "noOdd" function is called successfully
            emit SuccessEvent();
            return _success;
        } catch Error(string memory reason){
            // if "noOdd" is not called correctly
            emit CatchEvent(reason);
        }
    }

    // Use try-catch dealing with contract creation exceptions
    function executeNew(uint256 amount) external returns (bool success) {
        try new NoOdd(amount) returns (NoOdd even_) {
            //if call successfully
            emit SuccessEvent();
            return even_.noOdd(amount);
        } catch Error(string memory reason) {
            // catch revert() and require()
            emit CatchEvent(reason);
        } catch (bytes memory reason) {
            //catch assert()
            emit CatchByte(reason);
        }
    }
}