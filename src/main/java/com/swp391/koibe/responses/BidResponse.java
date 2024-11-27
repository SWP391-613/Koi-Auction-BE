package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;

public record BidResponse (
    @JsonProperty("bidder_id") Long bidderId,
    @JsonProperty("auction_koi_id") Long auctionKoiId,
    @JsonProperty("bid_amount") Long bidAmount,
    @JsonProperty("bid_time") String bidTime,
    @JsonProperty("bidder_name") String bidderName
) {}