// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address sender_addr;

    struct WavesInfo {
        address sender;
        uint256 waveCount;
    }

    WavesInfo[] public waves;

    constructor() {
        console.log("sup");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
        waves.push(WavesInfo({sender: msg.sender, waveCount: totalWaves}));
        for (uint i=0; i<totalWaves; i++) {
            console.log("Wave info addr: %s count: %d", waves[i].sender, waves[i].waveCount);
        }
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        
        return totalWaves;
    }
}