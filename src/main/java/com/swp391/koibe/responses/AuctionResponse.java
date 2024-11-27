package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.EAuctionStatus;
import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;

@JsonInclude(JsonInclude.Include.NON_NULL)
public record AuctionResponse(
    @JsonProperty("id") Long id,
    @JsonProperty("title") String title,

    @JsonProperty("start_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSSSSS")
    LocalDateTime startTime,

    @JsonProperty("end_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSSSSS")
    LocalDateTime endTime,

    @JsonProperty("status") EAuctionStatus status,
    @JsonProperty("auctioneer_id") Long auctioneerId
) {}
