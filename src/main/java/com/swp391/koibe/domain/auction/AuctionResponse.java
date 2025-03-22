package com.swp391.koibe.domain.auction;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.domain.auction.AuctionKoiPort.AuctionKoiResponse;
import com.swp391.koibe.enums.EAuctionStatus;
import java.time.LocalDateTime;
import java.util.List;

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
    @JsonProperty("auctioneer_id") Long auctioneerId,

    @JsonProperty("auction_koi")
    @JsonInclude(JsonInclude.Include.NON_NULL)
    List<AuctionKoiResponse> auctionKoi
) {

}
