package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BidMethodQuantityResponse {

    @JsonProperty("total")
    private Integer total;

    @JsonProperty("ascending_bid")
    private Long ascendingBid;

    @JsonProperty("descending_bid")
    private Long descendingBid;

//    @JsonProperty("sealed_bid")
//    private Long sealedBid;

    @JsonProperty("fixed_price")
    private Long fixedPrice;

}
