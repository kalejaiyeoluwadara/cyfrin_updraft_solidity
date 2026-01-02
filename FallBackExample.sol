// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FallBackExample {
    uint256 result;

    receive() external payable{
        result = 1;
    }
}