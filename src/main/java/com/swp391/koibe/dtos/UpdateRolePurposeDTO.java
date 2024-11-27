package com.swp391.koibe.dtos;

import jakarta.validation.constraints.NotBlank;

public record UpdateRolePurposeDTO(
    @NotBlank(message = "Update role Purpose is required")
    String purpose
) {}
