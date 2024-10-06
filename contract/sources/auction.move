module auction_addr:: auction{
    use std::vector;
    use std::signer;
    use aptos_framework::timestamp;
    use std::string::String;
    use aptos_std::coin::{transfer};
    use aptos_framework::aptos_coin::AptosCoin;

    struct Bid has key,copy,store{
        bidder:address,
        amount: u64
    }
    struct AuctionItem has key, store, copy {
        index: u64,
        seller: address,
        highest_bid: u64,
        highest_bidder: address,
        start_time: u64,
        end_time: u64,
        item_description: String,
        is_active: bool,
        bids: vector<Bid>
    }
    struct AuctionTable has key, store {
        auctions: vector<AuctionItem>,
    }
    public fun init_auction_table(account: &signer) {
        move_to(account, AuctionTable { auctions: vector::empty<AuctionItem>() });
    }
    public fun create_auction(
        account: &signer,
        start_time: u64,
        end_time: u64,
        item_description: String
    ) acquires AuctionTable{
        let seller_address = signer::address_of(account);
        assert!(end_time > start_time, 1); // Ensure auction ends after it starts
        let auction_index = vector::length(&borrow_global<AuctionTable>(seller_address).auctions); // Get the current auction count as index
        let auction = AuctionItem {
            index: auction_index,
            seller: seller_address,
            highest_bid: 0,
            highest_bidder: seller_address,
            start_time: start_time,
            end_time: end_time,
            item_description: item_description,
            is_active: true,
            bids: vector::empty<Bid>()
        };
        let auction_table = borrow_global_mut<AuctionTable>(seller_address);
        vector::push_back(&mut auction_table.auctions, auction);
    }

    public fun place_bid(
        bidder: &signer,
        auction_index: u64,
        bid_amount: u64
    ) acquires AuctionTable{
        let current_time = timestamp::now_seconds();
        let bidder_address = signer::address_of(bidder);

        let auction_table = borrow_global_mut<AuctionTable>(bidder_address);
        let auction = vector::borrow_mut(&mut auction_table.auctions, auction_index);

        // Check if auction is active
        assert!(auction.is_active, 2);

        // Check if current time is within auction period
        assert!(current_time >= auction.start_time, 3);
        assert!(current_time <= auction.end_time, 4);

        // Ensure new bid is higher than the previous highest
        assert!(bid_amount > auction.highest_bid, 5);
        let new_bid = Bid {
            bidder: bidder_address,
            amount: bid_amount,
        };
        vector::push_back(&mut auction.bids, new_bid);
        // Update the highest bid and highest bidder
        auction.highest_bid = bid_amount;
        auction.highest_bidder = bidder_address;

    }

    public fun end_auction(seller: &signer, auction_index: u64, highest_bidder: &signer)acquires AuctionTable {
        let current_time = timestamp::now_seconds();
        let seller_address = signer::address_of(seller);

        let auction_table = borrow_global_mut<AuctionTable>(seller_address);
        let auction = vector::borrow_mut(&mut auction_table.auctions, auction_index);

        // Ensure auction is still active and time has passed
        assert!(auction.is_active, 6);
        assert!(current_time > auction.end_time, 7);

        // Mark auction as inactive
        auction.is_active = false;

        // Transfer the bid amount (APT) from highest bidder to seller
        let highest_bidder_address = signer::address_of(highest_bidder);
        assert!(highest_bidder_address == auction.highest_bidder, 8); // Ensure the highest bidder is the signer

        transfer<AptosCoin>(highest_bidder, seller_address, auction.highest_bid);

        // End of auction logic (e.g., notify seller, highest bidder, etc.)
    }
    public fun get_all_auctions(account : &signer)  : vector<AuctionItem> acquires AuctionTable{
        let auction_table=borrow_global<AuctionTable>(signer::address_of(account));
        auction_table.auctions
    }
    public fun get_all_auctions_for_product(auction_index: u64, account : &signer) : vector<Bid> acquires AuctionTable{
        let auction_table = borrow_global<AuctionTable>(signer::address_of(account));
        let auction = vector::borrow(&auction_table.auctions, auction_index);
        auction.bids
    }
}
