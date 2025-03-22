package com.swp391.koibe.domain.auction;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.api.BasePaginationResponse;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuctionKoiPaginationResponse extends BasePaginationResponse {

    @JsonProperty("item")
    private List<AuctionKoiPort.AuctionKoiResponse> items; // List of auction koi
}
