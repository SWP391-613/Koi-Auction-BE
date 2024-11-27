package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDateTime;

public record FeedbackResponse(
    @JsonProperty("content") String content,
    @JsonProperty("rating") Integer rating,
    @JsonProperty("created_at") LocalDateTime createAt
) {}
