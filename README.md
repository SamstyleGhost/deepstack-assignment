### Smart Contract Implementation

Firstly, I built a smart contract for a normal auction with specified start and end dates. After it ran successfully, moved on to implementing the randomness part. The best option to achieve randomness was the Chainlink VRF which was widely used. Unfortunately, it turned out to be a paid service with the approximate costs above 10$. So, I turned to a pseudo random approach by using a hash function - keccak256. With the combination of this hash function with the block number and a time taken by the user, wrote a short formula that would generate a pseudo-random time.
- So, if the user sets the duration as 1 day for the auction, the actual duration could be anything from 12 to 24 days. So, any user who wants to bid has to bid at the earliest because the auction could end any moment randomly.

To build the smart contract, I used Remix as the IDE. To deploy and test the contract, I used Hardhat. The smart contract is in a working condition and does work locally.

#### Frontend
For the frontend implementation, I went with SolidJS with TailwindCSS. And used ethers.js as my library of choice for this assignment.
