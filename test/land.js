const {expect} = require("chai");
const {ethers} = require("hardhat");
const {assert} = require("chai");
 
describe("Land Registration", function (){
 let _land;
 let admin;
 let users;
 let accounts;
 let superAdmin;
 
before("deploy contract first",async ()=>{
  const Land = await ethers.getContractFactory("land");
  _land =await Land.deploy();
   await _land.deployed();
   accounts = ethers.provider.getSigner(0);
   [superAdmin,admin,users] =  await ethers.provider.listAccounts();
  

});
 
  it("it should set the owner to be the deployer of the contract", async ()=> {
  assert.equal(await _land.creatorAdmin(), superAdmin);
  });
  // it("Admin approved", async()=>{
  //   assert.equal(await _land.users.creatorAdmin, admin,);
  // });
  // it("User approved", async()=>{
  //   assert.equal(await _land.users.creatorAdmin, users);
  // });

  
    

   
});




    //const addedUser = await _land.users.creatorAdmin;
    // const approved_user = await ethers.getSigners();
    //const use = await _land.approveUsers.users;
    //[owner,user1] =  await ethers.provider.listAccounts();
    //use = assert.equal(await addedUser, approved_user)
    //console.log(addedUser);

  //   let err ="";
  //   try{
  //     await approved_user.approveUsers.users.creatorAdmin(3);
  //   }catch(e){
  //     err = e.message;
  //   }
  
  //   //expect(err).to.equal("VM Exception while processing transaction: reverted with reason string 'User should be approved!'");
  //   // const _user = _land.connect(user1);
  //   // const User = await _user.addNewUser();
  //   // await User.wait();
  //   // expect(await (_land.addNewUser(_user).toequal(_user)));

  // });
  // it("user approved", async()=>{
  //   const _user = _land.approveUsers(user2.address);
  //   expect (await _land.addNewUser()).to.equal(_user);