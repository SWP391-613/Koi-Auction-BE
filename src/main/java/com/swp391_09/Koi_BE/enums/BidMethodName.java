package com.swp391_09.Koi_BE.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum BidMethodName {

    FIXED_PRICE,
    SEALED_BID,
    ASCENDING_BID,
    DESCENDING_BID;
}
