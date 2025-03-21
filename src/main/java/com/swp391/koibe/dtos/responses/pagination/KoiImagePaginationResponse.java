package com.swp391.koibe.dtos.responses.pagination;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.dtos.responses.KoiImageResponse;
import com.swp391.koibe.api.BasePaginationResponse;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class KoiImagePaginationResponse extends BasePaginationResponse {

    @JsonProperty("items")
    private List<KoiImageResponse> items;

}
