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

    constructor() payable {
        console.log("sup");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        // Add wave data to array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // emit event that we had a new wave
        emit NewWave(msg.sender, block.timestamp, _message);

        // give prize to address sending wave
        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
}