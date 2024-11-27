package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.time.LocalDateTime;

public record PaymentResponse(
    @JsonProperty("id") Long id,
    @JsonProperty("payment_amount") Float paymentAmount,
    @JsonProperty("payment_date") LocalDateTime paymentDate,
    @JsonProperty("payment_method") String paymentMethod,
    @JsonProperty("payment_status") String paymentStatus, // e.g., SUCCESS, PENDING, REFUNDED
    @JsonProperty("order_id") Long orderId,
    @JsonProperty("user") UserResponse user,
    @JsonProperty("payment_type") String paymentType, // e.g., 'DEPOSIT', 'ORDER', 'DRAW_OUT'
    @JsonProperty("bank_number") String bankNumber,
    @JsonProperty("bank_name") String bankName
) {}
