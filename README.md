# Aptos BidVerse

This project implements a decentralized auction system using the Aptos blockchain. The platform allows users to create auctions, place bids, and finalize auctions in a secure, trustless manner. It leverages Aptos' Move language for smart contract development, providing a decentralized and efficient marketplace for bidding on products.

## Features

- **Auction Creation**: Sellers can create auctions with a start and end time, and a description of the item being auctioned.
- **Bidding**: Buyers can place bids on active auctions. The highest bid is tracked, and the highest bidder is updated with each valid bid.
- **Auction Finalization**: Once the auction time has passed, the seller can finalize the auction. The highest bidder pays the winning amount, and the auction is marked as completed.
- **Global Auction View**: Users can view all auctions and the bids placed on specific products.
- **Secure Payments**: The highest bid amount is transferred securely from the buyer to the seller using Aptos' native token (APT).

## Smart Contract Overview

### Data Structures

- **Bid**: Represents a bid on an auction, containing the bidder's address and the amount.
- **AuctionItem**: Represents an auction item with details such as the seller's address, highest bid, start and end times, item description, and bids.
- **AuctionTable**: A global structure that stores all auctions.

### Functions

- **`init_auction_table(account: &signer)`**: Initializes the auction table for a user.
- **`create_auction(account: &signer, start_time: u64, end_time: u64, item_description: String)`**: Creates a new auction for an item, storing it in the global auction table.
- **`place_bid(bidder: &signer, auction_index: u64, bid_amount: u64)`**: Places a bid on an auction. The bid must be higher than the current highest bid.
- **`end_auction(seller: &signer, auction_index: u64, highest_bidder: &signer)`**: Ends the auction once the time has passed. The highest bid is transferred to the seller, and the auction is marked inactive.
- **`get_all_auctions(account: &signer): vector<AuctionItem>`**: Returns a list of all auctions created by the given account.
- **`get_all_auctions_for_product(auction_index: u64, account: &signer): vector<Bid>`**: Retrieves all bids placed on a specific auction.

## How It Works

1. **Auction Creation**: A user (seller) can create an auction by specifying the start and end times, along with an item description. Each auction is assigned a unique index in the auction table.
2. **Bidding**: A user (buyer) can place a bid on any active auction. Each bid must be higher than the previous highest bid, and the highest bidder is updated accordingly.
3. **Ending the Auction**: After the auction ends (end time has passed), the seller can call the `end_auction` function to transfer the highest bid to their account, marking the auction as inactive.

## Installation and Usage

1. Clone this repository.
2. Compile the Move modules.
3. Deploy the contract to the Aptos blockchain.
4. Interact with the contract using the Aptos CLI or through a dApp interface.

## Example Usage

### Creating an Auction

```move
create_auction(signer, 1234567890, 1234569999, "Rare Collectible Item");
