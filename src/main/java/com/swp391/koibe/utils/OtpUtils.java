package com.swp391.koibe.utils;

public class OtpUtils {

    public static String generateOtp() {
        return String.valueOf((int) (Math.random() * 9000) + 1000);
    }

}
