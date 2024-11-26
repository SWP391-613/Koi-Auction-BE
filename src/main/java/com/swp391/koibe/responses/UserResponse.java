package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

public record UserResponse(
    @JsonProperty("id") Long id,
    @JsonProperty("first_name") String firstName,
    @JsonProperty("last_name") String lastName,
    @JsonProperty("phone_number") String phoneNumber,
    @JsonProperty("email") String email,
    @JsonProperty("address") String address,
    @JsonIgnore @JsonProperty("password") String password,
    @JsonProperty("is_active") int isActive,
    @JsonProperty("is_subscription") int isSubscription,
    @JsonProperty("status_name") String statusName,
    @JsonProperty("date_of_birth") String dob,
    @JsonProperty("avatar_url") String avatarUrl,
    @JsonProperty("google_account_id") int googleAccountId,
    @JsonProperty("role_name") String roleName,
    @JsonProperty("account_balance") long accountBalance,
    @JsonProperty("created_at") String createdAt,
    @JsonProperty("updated_at") String updatedAt
) {}
