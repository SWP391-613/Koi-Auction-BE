package com.swp391.koibe.dtos.responses;

import com.fasterxml.jackson.annotation.JsonProperty;


public record MemberResponse(
    @JsonProperty("user_response") UserResponse userResponse,
    @JsonProperty("order_count")
    Long orderCount
) {}
