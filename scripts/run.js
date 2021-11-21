


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
  
  // Call wave twice to see if user wins prize
  const waveTxn = await waveContract.wave('This is wave #1');
  await waveTxn.wait();

  await delay(31);

  const waveTxn2 = await waveContract.wave('This is wave #2');
  await waveTxn2.wait();

  // Get contract balance after wave called
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  // get all wave data
  waveData = await waveContract.getAllWaves();
  console.log("Wave data:", waveData);
}

function delay(n){
  return new Promise(function(resolve){
      setTimeout(resolve,n*1000);
  });
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