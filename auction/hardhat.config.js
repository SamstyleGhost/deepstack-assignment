require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  defaultNetwork: "sepolia",
  networks: {
    hardhat: {},
    sepolia: {
      url: process.env.INFURA_API_KEY,
      accounts: process.env.ACCOUNTS_PRIVATE_KEY,
      chainId: 11155111
    }
  }
};
