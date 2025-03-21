package com.swp391.koibe.domain.auction;

import com.swp391.koibe.domain.user.User;

public interface Biddable {
    AuctionKoi ascending(AuctionKoi auctionKoi, User bidder, Bid bid) throws Exception;
    AuctionKoi descending(AuctionKoi auctionKoi, User bidder, Bid bid) throws Exception;
    AuctionKoi fixedPrice(AuctionKoi auctionKoi, User bidder, Bid bid) throws Exception;
    AuctionKoi sealed(AuctionKoi auctionKoi, User bidder, Bid bid) throws Exception;
}
