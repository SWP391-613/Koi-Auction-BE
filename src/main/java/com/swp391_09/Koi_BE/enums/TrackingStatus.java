package com.swp391_09.Koi_BE.enums;

import java.util.Random;

public enum TrackingStatus {

    UNVERIFIED, VERIFIED, REJECTED, DELETED;


    private static final Random RANDOM = new Random();

    /**
     * Returns a random TrackingStatus value.
     */
    public static TrackingStatus getRandomStatus() {
        TrackingStatus[] statuses = values();
        return statuses[RANDOM.nextInt(statuses.length)];
    }
}
