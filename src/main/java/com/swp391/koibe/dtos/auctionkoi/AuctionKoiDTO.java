package com.swp391.koibe.dtos.auctionkoi;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.core.util.Json;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;
import lombok.Builder;

@Builder
public record AuctionKoiDTO(
    @JsonProperty("base_price")
    @NotNull(message = "Base rice is required")
    @Positive(message = "Base price must be positive")
    @Min(value = 1000000, message = "Minimum koi register to auction price is 1.000.000 VND")
    @Max(value = 50000000, message = "Maximum koi register to auction price is 50.000.000 VND")
    long basePrice,

    @JsonProperty("bid_step")
    long bidStep,

    @JsonProperty("bid_method")
    @NotBlank(message = "Bid Method is required")
    @Pattern(regexp = "FIXED_PRICE|SEALED_BID|ASCENDING_BID|DESCENDING_BID", message = "Bid Method must be either FIXED_PRICE, SEALED_BID, ASCENDING_BID, DESCENDING_BID")
    String bidMethod,

    //this field is optional, can be null but will set later, if the auction is ONGOING
    @Positive(message = "Current bid must be positive")
    @JsonProperty("current_bid") Long currentBid,
    @Positive(message = "Current bidder ID must be positive")
    @JsonProperty("current_bidder_id") Long currentBidderId,
    @JsonProperty("is_sold") boolean isSold,

    @Positive(message = "Auction ID must be positive")
    @NotNull(message = "Auction ID is required")
    @JsonProperty("auction_id") Long auctionId,

    @Positive(message = "Koi ID must be positive")
    @NotNull(message = "Koi ID is required")
    @JsonProperty("koi_id") Long koiId,

    @JsonProperty("ceil_price") Long ceilPrice,

    @JsonProperty("revoked") int revoked
) {}
