const { ethers } = require("ethers");

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */



// task("accounts","prints the list of accounts", async()=>{
//   const accounts = await ethers.getSigners();

//   for (const account of accounts){
//     console.log(account.address);
//   }
// });

module.exports={
  solidity: "0.8.17",
  networks:{
    hardhat:{
     forking:{
      url:process.env.ALCHEMY_KEY,
     },
     rinkeby:{
      url: process.env.STAGING_QUICKNODE_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
    },
  },
};


// module.exports={
//   solidity: "0.8.17",
//   networks:{
//     rinkeby:{
//       url: process.env.STAGING_QUICKNODE_KEY,
//       accounts: [process.env.PRIVATE_KEY],
//     },
//   },
// };