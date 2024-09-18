package com.swp391_09.Koi_BE.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EAuctionStatus {

    ONGOING("ONGOING"),
    ACTIVE("ACTIVE"),
    ENDED("ENDED");

    private final String status;

}
