package com.swp391.koibe.domain.koi;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.api.BasePaginationResponse;
import com.swp391.koibe.api.PageResponse;
import com.swp391.koibe.metadata.PaginationMeta;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@EqualsAndHashCode(callSuper = true)
@Data
public class KoiInAuctionPaginationResponse extends BasePaginationResponse {

    @JsonProperty("item")
    private List<KoiInAuctionResponse> item;

    public static PageResponse<KoiInAuctionResponse> fromPage(Page<KoiInAuctionResponse> koiPage, Pageable pageable) {
        List<KoiInAuctionResponse> koiResponses = koiPage.getContent();

        return PageResponse.<KoiInAuctionResponse>pageBuilder()
            .data(koiResponses)
            .pagination(PaginationMeta.builder()
                            .totalPages(koiPage.getTotalPages())
                            .totalItems(koiPage.getTotalElements())
                            .currentPage(pageable.getPageNumber())
                            .pageSize(pageable.getPageSize())
                            .build())
            .statusCode(200)
            .isSuccess(true)
            .message("Find all koi by keyword successfully")
            .build();
    }

}
