package com.swp391.koibe.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

public record FeedbackDTO(
    @JsonProperty("content") String content,
    @JsonProperty("rating") int rating,
    @JsonProperty("user_id") @NotNull long userId,
    @JsonProperty("order_id") @NotNull long orderId)
{ }
