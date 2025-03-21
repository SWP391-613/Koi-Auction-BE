package com.swp391.koibe.dtos.responses.pagination;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.dtos.responses.KoiInAuctionResponse;
import com.swp391.koibe.api.BasePaginationResponse;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class KoiInAuctionPaginationResponse extends BasePaginationResponse {

    @JsonProperty("item")
    private List<KoiInAuctionResponse> item;

}
