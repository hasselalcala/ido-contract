# NEAR Token Auction

A fair token auction platform built on the NEAR Protocol, inspired by Gnosis EasyAuction. This platform enables batch auctions for initial token offerings with a fair price discovery mechanism.

## Overview

NEAR Token Auction is a smart contract that facilitates batch auctions, where a predefined amount of tokens is offered for sale. The auction mechanism ensures fair price discovery through a uniform clearing price model.

### Key Features

- **Batch Auction Mechanism**: All orders are collected during the bidding period and settled at a uniform clearing price
- **Fair Price Discovery**: Final price is determined by matching buy orders from highest to lowest until the supply is exhausted
- **Token Standards**: Built using NEAR's fungible token standards (NEP-141)
- **Storage Management**: Efficient storage handling with proper deposit/withdrawal mechanisms
- **Order Management**: Supports order placement, cancellation, and settlement

## How it Works

### Auction Flow

1. **Initialization**: 
   - Auctioneer creates auction specifying:
     - Token to be sold (auctioning token)
     - Minimum price
     - Auction duration
     - Total supply for sale

2. **Bidding Phase**:
   - Bidders register and place orders with their desired:
     - Amount of tokens to buy
     - Maximum price willing to pay
   - Orders can be placed until auction end time

3. **Settlement**:
   - After auction ends, the final price is calculated
   - Winning orders are determined
   - Tokens are distributed to winning bidders
   - Excess payments are refunded

### Price Discovery

The final clearing price is determined by:
- Sorting all buy orders from highest to lowest price
- Accumulating order volumes until reaching total supply
- Setting uniform clearing price at the last included order
- All winning bids pay the same clearing price

## Technical Implementation

### Contract Structure

```
pub struct Contract {
   token: FungibleToken,
   metadata: LazyOption<FungibleTokenMetadata>,
   auction: Auction,
   orders: Vector<Order>
}
```



### Key Methods

- `new`: Initialize new auction
- `register_bidder`: Register account for participation
- `place_order`: Submit bid for tokens
- `settle_auction`: Calculate final price and winners
- `claim_tokens`: Withdraw won tokens
- `refund_deposit`: Return funds for non-winning bids

## Usage

### For Auctioneers

Deploy contract
```
near deploy --wasmFile res/fungible_token.wasm --accountId auction.near
```

Initialize auction

```
near call auction.near new '{"owner_id": "owner.near","total_supply": "1000000000000000","metadata": {...},"auction_duration": "100000000000","min_buy_amount": "1000000000000000000000000"}' --accountId owner.near
```

### For Bidders

Register as bidder

```
near call auction.near register_bidder --accountId bidder.near --deposit 0.1
```

Place order

```
near call auction.near place_order '{"buy_amount": "1000000000000000000"}' --accountId bidder.near --deposit 1
```

## Development

### Prerequisites

- NEAR CLI
- Rust 
- Near Workspaces for testing

### Building

```
cargo near build
```

### Testing
```
RUST_TEST_THREADS=1 cargo test -- --nocapture
```

## Security Considerations

- Implements proper storage management
- Handles decimal precision carefully
- Includes checks for overflow/underflow
- Validates auction parameters
- Ensures proper access control


## Acknowledgements

This implementation was inspired by [Gnosis EasyAuction](https://github.com/gnosis/ido-contracts), adapted for the NEAR Protocol ecosystem.