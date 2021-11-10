


const main = async() => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
  });
  await waveContract.deployed();

  console.log('deployed contract address: ', waveContract.address);

  // get initial contract balance
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );
  
  // call the contract function to wave and wait for it to finish
  let waveTxn = await waveContract.wave("tester message");
  await waveTxn.wait();

  // Get contract balance after wave called
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  // this time call wave function from a different public key/wallet
  waveTxn = await waveContract.connect(randomPerson).wave("Random person message");
  await waveTxn.wait();

  // get all wave data
  waveData = await waveContract.getAllWaves();
  console.log("Wave data:", waveData);

  // Get contract balance after 2nd wave called
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  contractBalance = await hre.ethers.provider.getBalance(randomPerson.address);
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );
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