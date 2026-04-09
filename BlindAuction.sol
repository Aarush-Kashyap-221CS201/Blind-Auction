// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Blind Auction (Commit-Reveal)
 * @author Student
 * @notice Implements blind auction to prevent front-running
 * @dev Uses commit-reveal scheme with keccak256 hash
 */
contract BlindAuction {

    struct Bid {
        bytes32 commitment;
        uint value;
        bool revealed;
    }

    mapping(address => Bid) public bids;

    address public auctionWinner;
    uint public highestBid;

    bool public commitPhase = true;
    bool public revealPhase = false;

    /**
     * @notice Submit hashed bid during commit phase
     * @param _commitment keccak256(bid, secret)
     */
    function commitBid(bytes32 _commitment) public {
        require(commitPhase, "Commit phase ended");

        bids[msg.sender].commitment = _commitment;
    }

    /**
     * @notice End commit phase and start reveal phase
     */
    function startReveal() public {
        commitPhase = false;
        revealPhase = true;
    }

    /**
     * @notice Reveal actual bid value
     * @param _value actual bid
     * @param _secret secret salt
     */
    function revealBid(uint _value, string memory _secret) public {
        require(revealPhase, "Reveal phase not started");

        Bid storage bid = bids[msg.sender];
        require(!bid.revealed, "Already revealed");

        bytes32 hash = keccak256(abi.encodePacked(_value, _secret));

        if (hash == bid.commitment) {
            bid.value = _value;

            if (_value > highestBid) {
                highestBid = _value;
                auctionWinner = msg.sender;
            }
        }

        bid.revealed = true;
    }

    /**
     * @notice Get winner address
     */
    function getWinner() public view returns(address) {
        require(revealPhase, "Reveal not finished");
        return auctionWinner;
    }
}