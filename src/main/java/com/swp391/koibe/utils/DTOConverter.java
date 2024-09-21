package com.swp391.koibe.utils;

import com.swp391.koibe.models.Koi;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.KoiResponse;
import com.swp391.koibe.responses.UserResponse;

public class DTOConverter {

    public static UserResponse convertToUserDTO(User user) {
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

    public static KoiResponse convertToKoiDTO(Koi koi) {
        return KoiResponse.builder()
            .id(koi.getId())
            .name(koi.getName())
            .sex(koi.getSex())
            .length(koi.getLength())
            .age(koi.getAge())
            //.basePrice(koi.getBasePrice())
            .statusName(koi.getStatus() != null ? koi.getStatus().getStatus() : null)
            .idDisplay(koi.getIsDisplay())
            .thumbnail(koi.getThumbnail())
            .description(koi.getDescription())
            .ownerId(koi.getOwner().getId())
            .categoryId(koi.getCategory().getId())
            .build();
    }

}
