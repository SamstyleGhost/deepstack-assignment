// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Auction {
    struct Auc {
        uint auctionId;
        address payable owner;
        string item; // offchain data
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

    event AuctionCreated(uint auctionId, address owner, string item, uint startingPrice, uint startBlock, uint endBlock);
    event NewBid(uint auctionId, address bidder, uint bid);
    event AuctionEnded(uint auctionId, address winner, uint winningBid);

    function createAuction(string memory item, uint startingPrice, uint durationBlocks) public {

        // require(startBlock > block.number);

        uint endBlock = block.number + durationBlocks;

        Auc storage auc = auctionList[auctionCount];

        auc.auctionId = auctionCount;
        auc.owner = payable(msg.sender);
        auc.item = item;
        auc.startingPrice = startingPrice;
        auc.startBlock = block.number;
        auc.highestBid = 0;

        emit AuctionCreated(auctionCount, msg.sender, item, startingPrice, block.number, endBlock);
        auctionCount++;
    }

    function bid(uint auctionId) public payable {
        Auc storage auc = auctionList[auctionId];
        require(block.number <= auc.endBlock, "Auction has ended");
        require(msg.value > auc.highestBid, "Bid must be higher than current highest bid");
        require(msg.sender != auc.owner);

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
        require(msg.sender == auc.owner, "Only the auction owner can end the auction");

        if (auc.highestBidder != address(0)) {
            auc.owner.transfer(auc.highestBid);
        }

        emit AuctionEnded(auctionId, auc.highestBidder, auc.highestBid);
    }

    function getAuctionDetails(uint auctionId) public view returns (
        uint auctionId_,
        address owner,
        string memory item,
        uint startingPrice,
        uint startBlock,
        uint endBlock,
        address highestBidder,
        uint highestBid
    ) {
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

    receive() external payable {}

}
