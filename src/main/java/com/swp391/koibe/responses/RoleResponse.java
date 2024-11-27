package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.UserRole;
import com.swp391.koibe.models.Role;
import java.util.List;

public record RoleResponse(
    @JsonProperty("id") Long id,
    @JsonProperty("name") UserRole name
) {}
