package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.EBidMethod;
import com.swp391.koibe.enums.EKoiGender;
import com.swp391.koibe.enums.EKoiStatus;
import java.time.LocalDateTime;

@JsonInclude(JsonInclude.Include.NON_NULL)
public record KoiInAuctionResponse(
    @JsonProperty("id") Long id,
    @JsonProperty("name") String name,
    @JsonProperty("sex") EKoiGender sex,
    @JsonProperty("length") Integer length,
    @JsonProperty("year_born") Integer yearBorn,
    @JsonProperty("base_price") Long price,
    @JsonProperty("status_name") String statusName,
    @JsonProperty("is_display") Integer isDisplay,
    @JsonProperty("thumbnail") String thumbnail,
    @JsonProperty("description") String description,
    @JsonProperty("owner_id") Long ownerId,
    @JsonProperty("category_id") Integer categoryId,
    @JsonProperty("created_at") LocalDateTime createdAt,
    @JsonProperty("updated_at") LocalDateTime updatedAt,
    @JsonProperty("auction_id") Long auctionId,
    @JsonProperty("bid_method") EBidMethod bidMethod,
    @JsonProperty("total_page") Integer totalPage
) {

    public KoiInAuctionResponse(Long id, String name, EKoiGender sex, int length, int yearBorn,
                                Long price,
                                EKoiStatus status, int isDisplay, String thumbnail,
                                String description,
                                Long ownerId, Integer categoryId, LocalDateTime createdAt,
                                LocalDateTime updatedAt,
                                Long auctionId, EBidMethod bidMethod) {
        this(id, name, sex, length, yearBorn, price, status.name(), isDisplay, thumbnail,
             description, ownerId, categoryId, createdAt, updatedAt, auctionId, bidMethod, null);
    }
}
