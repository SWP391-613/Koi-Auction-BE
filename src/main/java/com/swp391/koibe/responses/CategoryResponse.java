package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;

public record CategoryResponse (
    @JsonProperty("id")
    Long id,
    @JsonProperty("name")
    String name,
    @JsonProperty("koi_count")
    Long koiCount
) {}
