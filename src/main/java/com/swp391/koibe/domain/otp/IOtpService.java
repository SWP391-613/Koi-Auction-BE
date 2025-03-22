package com.swp391.koibe.domain.otp;

import java.util.Optional;

public interface IOtpService {

    void createOtp(Otp otp);
    void disableOtp(long id);
    Optional<Otp> getOtpByEmailOtp(String email, String otp);
    void setOtpExpired();
}
