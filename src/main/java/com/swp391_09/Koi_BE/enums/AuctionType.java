package com.swp391_09.Koi_BE.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum AuctionType {

    SOLD(1),
    ONETIME(2),
    UP(3),
    DOWN(4);

    private final int type;

}
