package com.swp391.koibe.domain.user;

import com.fasterxml.jackson.annotation.JsonProperty;


public record MemberResponse(
    @JsonProperty("user_response") UserResponse userResponse,
    @JsonProperty("order_count")
    Long orderCount
) {}
