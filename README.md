# Simple Wave Portal Smart Contract

This project creates a smart contract providing a wave function that waves at the contract and keeps
a log of which address waved and when.

To build contract:
```
npx hardhat compile
```

To run test script:
```
npx hardhat run scripts/run.js
```

To deploy contract to Rinkeby:
```
npx hardhat run scripts/deploy.js --network rinkeby
```