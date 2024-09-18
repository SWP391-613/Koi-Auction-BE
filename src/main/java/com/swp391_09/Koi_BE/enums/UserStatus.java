package com.swp391_09.Koi_BE.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserStatus {

    ACTIVE("ACTIVE"),
    INACTIVE("INACTIVE"),
    VERIFIED("VERIFIED"),
    UNVERIFIED("UNVERIFIED"),
    BANNED("BANNED");

    private final String status;

}
