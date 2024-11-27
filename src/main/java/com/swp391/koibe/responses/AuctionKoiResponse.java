package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.EBidMethod;

@JsonInclude(JsonInclude.Include.NON_NULL)
public record AuctionKoiResponse (
    @JsonProperty("id") Long id,
    @JsonProperty("base_price") Long basePrice,
    @JsonProperty("ceil_price") Long ceilPrice,
    @JsonProperty("bid_step") Long bidStep,
    @JsonProperty("bid_method") EBidMethod bidMethod,
    @JsonProperty("current_bid") Long currentBid,
    @JsonProperty("current_bidder_id") Long currentBidderId,
    @JsonProperty("revoked") Integer revoked,
    @JsonProperty("is_sold") Boolean isSold,
    @JsonProperty("auction_id") Long auctionId,
    @JsonProperty("koi_id") Long koiId
) {}
