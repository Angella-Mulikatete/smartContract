//to run on a local network we type npx hardhat node
const { hexStripZeros } = require("ethers/lib/utils")

const main = async()=>{
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log("Deploying contracts with accounts:", deployer.address);
  console.log("AccountBalance:", accountBalance.toString());
  
  const landContractFactory = await hre.ethers.getContractFactory("land");
  const landContract = await landContractFactory.deploy();
  await landContract.deployed();

  console.log("land adrees:", landContract.address);

};

const runMain = async() =>{
  try{
    await main();
    process.exit(0);
  }catch(error){
    console.log(error);
    process.exit(1);
  }
};
runMain();
