package com.swp391.koibe.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.UserRole;
import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record RoleDTO(
    @JsonProperty("name")
    @NotBlank(message = "Role name is required")
    UserRole userRole
) {}
