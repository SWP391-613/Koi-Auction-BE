package com.swp391.koibe.dtos.responses.pagination;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.dtos.responses.BidResponse;
import com.swp391.koibe.api.BasePaginationResponse;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class BiddingHistoryPaginationResponse extends BasePaginationResponse {

    @JsonProperty("items")
    private List<BidResponse> items;

}
