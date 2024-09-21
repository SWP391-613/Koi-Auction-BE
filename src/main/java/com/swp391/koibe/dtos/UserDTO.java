package com.swp391.koibe.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserDTO {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("full_name")
    private String fullName;

    @JsonProperty("phone_number")
    private String phoneNumber;

    @JsonProperty("email")
    @Email(message = "Email should be valid")
    private String email;

    @JsonProperty("address")
    private String address;

    @JsonProperty("password")
    @NotBlank(message = "Password cannot be blank")
    private String password;

    @JsonProperty("status_name")
    private String statusName;

    @JsonProperty("date_of_birth")
    private Date dob;

    @JsonProperty("avatar_url")
    private String avatarUrl;

    @JsonProperty("google_account_id")
    private int googleAccountId;

    @JsonProperty("role_name")
    @NotNull(message = "Role name is required")
    private String roleName;

    @JsonProperty("wallet_id")
    private long walletId;

}
