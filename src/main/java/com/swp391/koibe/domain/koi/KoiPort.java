package com.swp391.koibe.domain.koi;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.EBidMethod;
import com.swp391.koibe.enums.EKoiGender;
import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.metadata.MediaMeta;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;
import java.time.LocalDateTime;

public interface KoiPort {

    @JsonInclude(JsonInclude.Include.NON_NULL)
    record KoiResponse(
        Long id,
        String name,
        EKoiGender sex,
        Integer length,
        @JsonProperty("year_born") Integer yearBorn,
        @JsonProperty("base_price") Long price,
        @JsonProperty("status_name") String statusName,
        @JsonProperty("is_display") Integer idDisplay,
        String thumbnail,
        String description,
        @JsonProperty("owner_id") Long ownerId,
        @JsonProperty("category_id") Long categoryId,

        @JsonIgnore
        @JsonProperty("created_at") LocalDateTime createdAt,

        @JsonIgnore
        @JsonProperty("updated_at") LocalDateTime updatedAt,

        @JsonProperty("total_page") Integer totalPage
        //this field is for holding the total number of pages (in case query directly from database)
        //and retrieve from redis cache
    ) {}

    record KoiGenderResponse(
        @JsonProperty("total") Integer total,
        @JsonProperty("male") Long male,
        @JsonProperty("female") Long female,
        @JsonProperty("unknown") Long unknown
    ) {}

    record KoiImageDTO(
        @JsonProperty("koi_id")
        @Min(value = 1, message = "Koi ID must be greater than 0")
        Long koiId,

        @JsonProperty("image_url")
        @Size(min = 5, max = 300, message = "Image URL must be between 5 and 300 characters")
        String imageUrl,

        @JsonProperty("video_url")
        @Size(min = 5, max = 300, message = "Video URL must be between 5 and 300 characters")
        String videoUrl
    ) {}

    @JsonInclude(Include.NON_NULL)
    record KoiImageResponse(
        @JsonProperty("id") Long id,
        @JsonProperty("koi_id") Long koiId,
        @JsonProperty("media_meta") MediaMeta mediaMeta
    ) {}

    @JsonInclude(JsonInclude.Include.NON_NULL)
    record KoiInAuctionResponse(
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
        @JsonProperty("category_id") Long categoryId,
        @JsonProperty("auction_id") Long auctionId,
        @JsonProperty("bid_method") EBidMethod bidMethod,
        @JsonProperty("total_page") Integer totalPage
    ) {

        public KoiInAuctionResponse(Long id, String name, EKoiGender sex, int length, int yearBorn,
                                    Long price,
                                    EKoiStatus status, int isDisplay, String thumbnail,
                                    String description,
                                    Long ownerId, Long categoryId,
                                    Long auctionId, EBidMethod bidMethod) {
            this(id, name, sex, length, yearBorn, price, status.name(), isDisplay, thumbnail,
                 description, ownerId, categoryId, auctionId, bidMethod, null);
        }
    }

    record KoiStatusResponse(
        @JsonProperty("total") Integer total,
        @JsonProperty("unverified") Long unverified,
        @JsonProperty("verified") Long verified,
        @JsonProperty("rejected") Long rejected,
        @JsonProperty("sold") Long sold
    ) {

    }


}
