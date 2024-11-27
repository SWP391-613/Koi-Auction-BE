package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;

public record KoiGenderResponse(
    @JsonProperty("total") Integer total,
    @JsonProperty("male") Long male,
    @JsonProperty("female") Long female,
    @JsonProperty("unknown") Long unknown
) {}
