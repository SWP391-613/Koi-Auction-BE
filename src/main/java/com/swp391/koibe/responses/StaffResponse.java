package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;

public record StaffResponse(
    @JsonProperty("user_response") UserResponse userResponse,
    @JsonProperty("auction_count") Long auctionCount
){}
