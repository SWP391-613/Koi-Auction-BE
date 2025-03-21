package com.swp391.koibe.dtos.responses;

import com.fasterxml.jackson.annotation.JsonProperty;

public record AuctionStatusCountResponse(
    @JsonProperty("total")
    Integer total,
    @JsonProperty("upcoming")
    Long upcoming,
    @JsonProperty("ongoing")
    Long ongoing,
    @JsonProperty("ended")
    Long ended
) {}