package com.swp391_09.Koi_BE.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EBidMethod {

    FIXED_PRICE("1"),
    SEALED_BID("2"),
    ASCENDING_BID("3"),
    DESCENDING_BID("4");

    private final String type;

}
