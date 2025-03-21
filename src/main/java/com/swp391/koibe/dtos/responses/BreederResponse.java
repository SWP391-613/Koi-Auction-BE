package com.swp391.koibe.dtos.responses;

import com.fasterxml.jackson.annotation.JsonProperty;

public record BreederResponse(
    @JsonProperty("user_response") UserResponse userResponse,
    @JsonProperty("koi_count") Long koiCount
) {}
