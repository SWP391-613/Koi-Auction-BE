package com.swp391.koibe.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class UserRegisterDTO {

    @JsonProperty("first_name")
    @NotBlank(message = "First name is required")
    private String firstName;

    @JsonProperty("last_name")
    @NotBlank(message = "Last name is required")
    private String lastName;

    @JsonProperty("email")
    @NotBlank(message = "Email is required")
    private String email;

    private String address;

    @NotBlank(message = "Password is required")
    private String password;

    @JsonProperty("retype_password")
    @NotBlank(message = "Retype password is required")
    private String retypePassword;

    @JsonProperty("date_of_birth")
    private Date dateOfBirth;

    @JsonProperty("facebook_account_id")
    private int facebookAccountId;

    @JsonProperty("google_account_id")
    private int googleAccountId;

    @JsonProperty("role_id")
    @NotNull(message = "Role ID is required")
    private Long roleId;

}