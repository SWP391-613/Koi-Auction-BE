package com.swp391.koibe.responses;

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
    private Long id;
    private String fullName;
    private String phoneNumber;
    private String email;
    private String address;
    private String password;
    private String statusName;
    private Date dob;
    private String avatarUrl;
    private int googleAccountId;
    private String roleName;
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
            .walletId(user.getWallet() != null ? user.getWallet().getId() : 0)
            .build();
    }
}
