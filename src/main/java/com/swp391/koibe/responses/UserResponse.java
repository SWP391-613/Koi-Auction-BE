package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.models.User;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserResponse {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("first_name")
    private String firstName;

    @JsonProperty("last_name")
    private String lastName;

    @JsonProperty("phone_number")
    private String phoneNumber;

    @JsonProperty("email")
    private String email;

    @JsonProperty("address")
    private String address;

    @JsonProperty("password")
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
    private String roleName;

    @JsonProperty("wallet_id")
    private long walletId;

}