package com.swp391.koibe.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.constants.Regex;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record UpdatePasswordDTO(
    @JsonProperty("email")
    @Email(message = "Email must be a valid email")
    @NotBlank(message = "Email must not be blank")
    String email,

    @JsonProperty("new_password")
    @Pattern(regexp = Regex.PASSWORD_REGEX, message = "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character")
    @NotBlank(message = "New password must not be blank")
    String newPassword
) {}
