// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    
    // Event to let the frontend we have a new wave
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;      // The address of the user who waved.
        string message;     // The message the user sent.
        uint256 timestamp;  // The timestamp when the user waved.
    }

    // variable to allow the store of the wave struct
    Wave[] waves;

    constructor() {
        console.log("sup");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
        waves.push(Wave(msg.sender, _message, block.timestamp));
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
}