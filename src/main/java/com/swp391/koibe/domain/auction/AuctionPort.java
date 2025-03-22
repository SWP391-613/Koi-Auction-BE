package com.swp391.koibe.domain.auction;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.EAuctionStatus;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;
import lombok.Builder;

public interface AuctionPort {

    record AuctionDTO (
        @JsonProperty("title")
        @NotBlank(message = "Title is required")
        @Schema(description = "Title of the auction", example = "Auction 1")
        String title,

        @JsonProperty("start_time")
        @NotBlank(message = "Start time is required")
        @Pattern(
            regexp = "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}\\.\\d{6}$",
            message = "Start time must be in the format yyyy-MM-dd HH:mm:ss.SSSSSS"
        )
            @Schema(description = "Start time of the auction", example = "2025-12-31 23:59:59"
                + ".999999")
        String startTime,

        @JsonProperty("end_time")
        @NotBlank(message = "End time is required")
        @Pattern(
            regexp = "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}\\.\\d{6}$",
            message = "End time must be in the format yyyy-MM-dd HH:mm:ss.SSSSSS"
        )
            @Schema(description = "End time of the auction", example = "2025-12-31 23:59:59"
                + ".999999")
        String endTime,

        @JsonProperty("status")
        EAuctionStatus statusName,

        @JsonProperty("auctioneer_id")
        @NotNull(message = "Auctioneer is required for one Auction")
        @Positive(message = "Auctioneer ID must be a positive number")
        long auctioneerId
    ) {}

}
