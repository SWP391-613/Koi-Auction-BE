package com.swp391_09.Koi_BE.dtos;

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

    @JsonProperty("full_name")
    private String fullName;

    @JsonProperty("email")
    @NotBlank(message = "Email is required")
    private String email;

    @JsonProperty("address")
    private String address;

    @JsonProperty("password")
    @NotBlank(message = "Password is required")
    private String password;

    @JsonProperty("status")
    private String status;

    @JsonProperty("retype_password")
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