require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  defaultNetwork: "sepolia",
  networks: {
    hardhat: {},
    sepolia: {
      url: `https://sepolia.infura.io/v3/56692ff5ffa241aaa9fbee9d2910c493`,
      accounts: [`0x204f1fa238836b3e58c01628a48bcc3c2f99537ff164d467e6391799724a4ed0`],
      chainId: 11155111
    }
  }
};
