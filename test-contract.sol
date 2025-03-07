// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestContract {
    uint256 public x;

    // Constructor sets an initial value
    constructor(uint256 _x) {
        x = _x;
    }

    // A simple function to update the value
    function setX(uint256 _x) public {
        x = _x;
    }
}
