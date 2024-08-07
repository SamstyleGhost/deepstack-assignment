// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Auction {
    struct Auc {
        uint auctionId;
        address payable owner;
        // The below item field is currently kept on-chain and is only identified as a string. But mostly, during actual implementation, this should rather be kept off-chain so as to reduce costs
        string item;
        uint startingPrice;
        uint startBlock;
        uint endBlock; // randomized
        address payable highestBidder;
        uint highestBid;
        mapping(address => uint) bidders;
        mapping(address => bool) hasWithdrawn;
    }

    mapping(uint => Auc) public auctionList;
    uint public auctionCount = 0;

    event AuctionCreated(
        uint auctionId,
        address owner,
        string item,
        uint startingPrice,
        uint startBlock,
        uint endBlock
    );
    event NewBid(uint auctionId, address bidder, uint bid);
    event AuctionEnded(uint auctionId, address winner, uint winningBid);

    // This is just a test function used to test the deployment
    function testAuction() public view returns (uint) {
        return auctionCount;
    }

    function createAuction(
        string memory item,
        uint startingPrice,
        uint durationBlocks
    ) public {
        // for testing purposes, this function just starts the auction as soon as it is created with a randomized end time. But in actual implementation, this field would be asked to the user as to when they wish to start the auction.

        // require(startBlock > block.number);
        uint random = setRandom(durationBlocks);

        // so that auctions run for at least half the length of the duration provided
        uint endBlock = block.number + (durationBlocks / 2) + random;

        Auc storage auc = auctionList[auctionCount];

        auc.auctionId = auctionCount;
        auc.owner = payable(msg.sender);
        auc.item = item;
        auc.startingPrice = startingPrice;
        auc.startBlock = block.number;
        auc.endBlock = endBlock;
        auc.highestBid = 0;

        emit AuctionCreated(
            auctionCount,
            msg.sender,
            item,
            startingPrice,
            block.number,
            endBlock
        );
        auctionCount++;
    }

    function bid(uint auctionId) public payable {
        // Gets the auction on which to bid on.
        Auc storage auc = auctionList[auctionId];

        require(block.number <= auc.endBlock, "Auction has ended");
        require(
            msg.value > auc.highestBid,
            "Bid must be higher than current highest bid"
        );
        require(msg.sender != auc.owner);

        // Refunds the previous highest bidder if they get outbid by someone else
        // Could maybe change this to be split up in functionality: 1. If the bidder was outbid, but still wants to continue bidding, then they can just up their price and send the diff, which would result in less back and forth transactions. 2. If the bidder does not wish to bid further, then they can just hit a withdraw button that will withdraw their money back
        if (auc.highestBidder != address(0)) {
            auc.highestBidder.transfer(auc.highestBid);
        }

        auc.highestBidder = payable(msg.sender);
        auc.highestBid = msg.value;
        auc.bidders[msg.sender] += msg.value;

        emit NewBid(auctionId, msg.sender, msg.value);
    }

    function endAuction(uint auctionId) public {
        Auc storage auc = auctionList[auctionId];
        require(block.number > auc.endBlock, "Auction not yet ended");
        require(
            msg.sender == auc.owner,
            "Only the auction owner can end the auction"
        );

        if (auc.highestBidder != address(0)) {
            auc.owner.transfer(auc.highestBid);
        }

        emit AuctionEnded(auctionId, auc.highestBidder, auc.highestBid);
    }

    function getAuctionDetails(
        uint auctionId
    )
        public
        view
        returns (
            uint auctionId_,
            address owner,
            string memory item,
            uint startingPrice,
            uint startBlock,
            uint endBlock,
            address highestBidder,
            uint highestBid
        )
    {
        Auc storage auc = auctionList[auctionId];
        return (
            auc.auctionId,
            auc.owner,
            auc.item,
            auc.startingPrice,
            auc.startBlock,
            auc.endBlock,
            auc.highestBidder,
            auc.highestBid
        );
    }

    function setRandom(uint duration) private view returns (uint) {
        uint random = (uint(
            keccak256(abi.encodePacked(block.number, msg.sender, duration))
        ) % duration) / 2;
        return random;
    }

    receive() external payable {}
}
