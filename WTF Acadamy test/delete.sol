// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DeleteContract {
    uint256 public value = 10;

    constructor() payable {}

    receive() external payable {}

    function deleteContract() external {
        // call selfdestruct() to destruct the contract and send the balance to msg.sender
        selfdestruct(payable (msg.sender));
    }

    function getBalance() external view returns (uint256 balance) {
        balance = address(this).balance;
    }
}