package com.swp391.koibe.repositories;

import com.swp391.koibe.models.Otp;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface OtpRepository extends JpaRepository<Otp, Long> {

    Optional<Otp> findByEmailAndOtp(String email, String otp);

    @Modifying
    @Query("UPDATE Otp o SET o.isExpired = true WHERE o.expiredAt < :now AND o.isExpired = false")
    void updateExpiredOtps(LocalDateTime now);

}
