// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Hash {
    function getHash(uint value, string memory secret) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(value, secret));
    }
}