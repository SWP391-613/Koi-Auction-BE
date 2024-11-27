package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;

public record BidMethodQuantityResponse (
    @JsonProperty("total") Integer total,
    @JsonProperty("ascending_bid") Long ascendingBid,
    @JsonProperty("descending_bid") Long descendingBid,

//    @JsonProperty("sealed_bid")
//    Long sealedBid,

    @JsonProperty("fixed_price") Long fixedPrice
) {}
