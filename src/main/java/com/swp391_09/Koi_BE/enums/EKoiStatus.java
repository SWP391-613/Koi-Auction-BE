package com.swp391_09.Koi_BE.enums;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EKoiStatus {

    UNVERIFIED("UNVERIFIED"),
    VERIFIED("VERIFIED"),
    REJECTED("REJECTED"),
    PENDING("PENDING"),
    SOLD("SOLD"),;

    private final String status;

}
