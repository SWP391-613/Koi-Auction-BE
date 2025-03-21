package com.swp391.koibe.dtos.responses.pagination;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.dtos.responses.KoiResponse;
import com.swp391.koibe.api.BasePaginationResponse;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class KoiPaginationResponse extends BasePaginationResponse {

    @JsonProperty("item")
    private List<KoiResponse> item;

}
