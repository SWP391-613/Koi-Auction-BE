package com.swp391.koibe.domain.otp;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDateTime;

public record OtpDTO(
    @JsonProperty("email") String email,
    @JsonProperty("otp") String otp,
    @JsonProperty("expired_at") LocalDateTime expiredAt,
    @JsonProperty("is_used") boolean isUsed,
    @JsonProperty("is_expired") boolean isExpired
) {}