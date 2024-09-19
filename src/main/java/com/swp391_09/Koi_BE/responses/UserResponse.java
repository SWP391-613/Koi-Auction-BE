package com.swp391_09.Koi_BE.responses;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391_09.Koi_BE.models.User;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserResponse {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("full_name")
    private String fullName;

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

    @JsonIgnore
    private long walletId;

    public static UserResponse convertToDTO(User user) {
        return UserResponse.builder()
            .id(user.getId())
            .fullName(user.getFullName())
            .phoneNumber(user.getPhoneNumber())
            .email(user.getEmail())
            .address(user.getAddress())
            //.password(user.getPassword())
            .statusName(user.getStatus() != null ? user.getStatus().getStatus() : null)
            .dob(user.getDob())
            .avatarUrl(user.getAvatarUrl())
            .googleAccountId(user.getGoogleAccountId())
            .roleName(user.getRole() != null ? user.getRole().getName() : null)
            //.walletId(user.getWallet() != null ? user.getWallet().getId() : 0)
            .build();
    }
}
