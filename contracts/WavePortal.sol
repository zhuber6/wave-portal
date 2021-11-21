// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;
    
    // Event to let the frontend we have a new wave
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;      // The address of the user who waved.
        string message;     // The message the user sent.
        uint256 timestamp;  // The timestamp when the user waved.
    }

    // variable to allow the store of the wave struct
    Wave[] waves;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("sup");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        // We need to make sure the current timestamp is at least 30-seconds bigger than the last timestamp we stored
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Wait 30s before waving again"
        );

        // Update the current timestamp we have for the user
        lastWavedAt[msg.sender] = block.timestamp;
        
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        // Add wave data to array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // generate a new seed for the next user that sends a wave
        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 50) {
            // give prize to address sending wave
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        
        // emit event that we had a new wave
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
}