package com.swp391.koibe.domain.auth;

import com.fasterxml.jackson.annotation.JsonProperty;

public record OAuth2DTO (
    @JsonProperty("token") String token
){}
