const { ethers } = require("hardhat");

async function main() {
  try {
    const Auction = await ethers.getContractFactory("Auction");
    const auction = await Auction.deploy();
    const auc = await auction.waitForDeployment();
    const address = await auc.getAddress();
    

    console.log("Contract deployed to: ", address);

    const network = await ethers.provider.getNetwork();
    console.log(`Deployed on network: ${network.name} with chainId: ${network.chainId}`);

    const testVal = await auction.testAuction();
    console.log("Test call is:", testVal);
  } catch (error) {
    console.error(error);
  }
  
}

main()
  .then(() => process.exit(0))
  .catch(err => {
    console.error(err);
    process.exit(1);
  })