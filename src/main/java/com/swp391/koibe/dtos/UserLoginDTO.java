package com.swp391.koibe.dtos;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record UserLoginDTO(
    @Email(message = "Email is not valid")
    @NotBlank(message = "Email is required")
    @Schema(description = "User email", example = "mnhw.0612@gmail.com")
    String email,

    @NotBlank(message = "Password is required")
    @Schema(description = "User password", example = "Luucaohoang1604^^")
    String password
) {

}
