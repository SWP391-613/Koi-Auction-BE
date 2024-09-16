package com.swp391_09.Koi_BE.enums;

import java.util.Random;

public enum KoiTrackingStatus {

    UNVERIFIED, VERIFIED, REJECTED, DELETED;


    private static final Random RANDOM = new Random();

    /**
     * Returns a random TrackingStatus value.
     */
    public static KoiTrackingStatus getRandomStatus() {
        KoiTrackingStatus[] statuses = values();
        return statuses[RANDOM.nextInt(statuses.length)];
    }
}
