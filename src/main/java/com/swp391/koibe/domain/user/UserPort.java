package com.swp391.koibe.domain.user;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import java.util.Date;

public interface UserPort {
    record UserResponse(
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

        @JsonIgnore
        @JsonProperty("created_at") String createdAt,

        @JsonIgnore
        @JsonProperty("updated_at") String updatedAt
    ) {}

    record BreederResponse(
        @JsonProperty("user_response") UserResponse userResponse,
        @JsonProperty("koi_count") Long koiCount
    ) {}

    record MemberResponse(
        @JsonProperty("user_response") UserResponse userResponse,
        @JsonProperty("order_count")
        Long orderCount
    ) {}

    record StaffRegisterDTO(

        @JsonProperty("first_name")
        @NotBlank(message = "First name is required") String firstName,

        @JsonProperty("last_name")
        @NotBlank(message = "Last name is required") String lastName,

        @NotBlank(message = "Email is required")
        @JsonProperty("email")
        @Email(message = "Email is invalid") String email,

        @NotBlank(message = "Phone number is required")
        @JsonProperty("phone_number")
        @Pattern(regexp = "^(\\+84|0)\\d{9,10}$", message = "Phone number is invalid") String phoneNumber,

        @JsonProperty("is_active")
        boolean isActive,

        @JsonProperty("is_subscription")
        boolean isSubscription,

        @JsonProperty("address")
        String address,

        @JsonProperty("password")
        @NotBlank(message = "Password is required") String password,

        @JsonProperty("date_of_birth")
        Date dateOfBirth,

        @JsonProperty("avatar_url")
        String avatarUrl,

        @JsonProperty("google_account_id")
        int googleAccountId
    ){}

    record StaffResponse(
        @JsonProperty("user_response") UserResponse userResponse,
        @JsonProperty("auction_count") Long auctionCount
    ){}

    @JsonInclude(JsonInclude.Include.NON_NULL)
    record UpdateUserDTO(
        @JsonProperty("first_name") String firstName,
        @JsonProperty("last_name") String lastName,
        @JsonProperty("email") String email,
        @JsonProperty("phone_number") String phoneNumber,
        @JsonProperty("password") String password,
        @JsonProperty("confirm_password") String confirmPassword, // in case user wants to change password
        @JsonProperty("address") String address,
        @JsonProperty("status")
        @Pattern(regexp = "ACTIVE|INACTIVE|VERIFIED|UNVERIFIED|BANNED", message = "Status must be either ONGOING, INACTIVE, VERIFIED, UNVERIFIED, BANNED")
        String status,
        @JsonProperty("date_of_birth") Date dob,
        @JsonProperty("avatar_url") String avatarUrl,
        @JsonProperty("google_account_id") int googleAccountId,
        @JsonProperty("balance_account") long balanceAccount
    ) {}

    record UserDTO(
        @JsonProperty("first_name") String firstName,

        @JsonProperty("last_name") String lastName,

        @JsonProperty("phone_number") String phoneNumber,

        @JsonProperty("email")
        @Email(message = "Email should be valid") String email,

        @JsonProperty("address") String address,

        @JsonProperty("password") String password,

        @JsonProperty("is_active") boolean isActive,

        @JsonProperty("is_subscription") boolean isSubscription,

        @Pattern(regexp = "UNVERIFIED|VERIFIED|BANNED", message = "Status must be either UNVERIFIED, VERIFIED, BANNED")
        @JsonProperty("status_name") String statusName,

        @JsonProperty("date_of_birth") String dob,

        @JsonProperty("avatar_url") String avatarUrl,

        @JsonProperty("google_account_id") int googleAccountId,

        @JsonProperty("account_balance") long accountBalance
    ) {}
}
