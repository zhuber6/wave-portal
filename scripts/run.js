


const main = async() => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);
  
  // get initial wave count
  let waveData;
  waveData = await waveContract.getAllWaves();
  
  // call the contract function to wave and wait for it to finish
  let waveTxn = await waveContract.wave("tester message");
  await waveTxn.wait();
  
  // get the total wave count again to make sure it incremented
  waveData = await waveContract.getAllWaves();
  console.log("Wave data:", waveData);
  
  // this time call wave function from a different public key/wallet
  waveTxn = await waveContract.connect(randomPerson).wave("Random person message");
  await waveTxn.wait();

  // get total waves again
  waveData = await waveContract.getAllWaves();
  console.log("Wave data:", waveData);
}

// get our main function to run asynchronously
const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();