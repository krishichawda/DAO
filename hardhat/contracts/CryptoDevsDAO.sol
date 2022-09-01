// SPDX-License-Identifier : MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
    Interface for the FakeNFTMarketplace
 */
interface IFakeNFTMarketplace {
    // Returns the price in Wei for an NFT
    function getPrice() external view returns (uint256);

    // Returns a boolean value, true - if token is available and vice versa
    function available(uint256 _tokenId) external view returns (bool);

    // the fake NFT tokenID to purchase
    function purchase(uint256 _tokenId) external payable;
}

/**
    Interface for CryptoDevsNFT containing only two functions that we are interested in
 */
interface ICryptoDevsNFT {
    function balanceOf(address owner) external view returns (uint256);

    function tokenOfOwnerByIndex(address owner, uint256 index)
        external
        view
        returns (uint256);
}

contract CryptoDevsDAO is Ownable {
    // Create a struct named Proposal containing all relevant information
    struct Proposal {
        // nftTokenId - the tokenId of the NFT to purchase from FakeNFTMarketplace if the proposal passes
        uint256 nftTokenId;
        // deadline - the UNIX timestamp until which this proposal is active. Proposal can be executed after the deadline has been executed.
        uint256 deadline;
        // yayVotes - number of yay votes for this proposal
        uint256 yayVotes;
        // nayVotes - number of nay votes for this proposal
        uint256 nayVotes;
        // executed - whether or not this proposal has been executed yet. Cannot be executed before the deadline has been executed.
        bool executed;
        // voters - a mapping of CryptoDevsNFT tokenIds to booleans indicating whether that NFT has already been used to cast a vote or not.
        mapping(uint256 => bool) voters;
    }

    // Create a mapping of ID to proposal
    mapping(uint256 => Proposal) public proposals;

    // Number of proposals that have been created..
    uint256 public numProposals;
}
