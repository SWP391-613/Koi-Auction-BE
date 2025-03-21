package com.swp391.koibe.dtos.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.UserRole;

public record RoleResponse(
    @JsonProperty("id") Long id,
    @JsonProperty("name") UserRole name
) {}
