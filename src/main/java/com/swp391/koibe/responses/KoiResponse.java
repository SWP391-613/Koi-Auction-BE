package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.EKoiGender;
import java.time.LocalDateTime;

@JsonInclude(JsonInclude.Include.NON_NULL)
public record KoiResponse(
    @JsonProperty("id") Long id,
    @JsonProperty("name") String name,
    @JsonProperty("sex") EKoiGender sex,
    @JsonProperty("length") Integer length,
    @JsonProperty("year_born") Integer yearBorn,
    @JsonProperty("base_price") Long price,
    @JsonProperty("status_name") String statusName,
    @JsonProperty("is_display") Integer idDisplay,
    @JsonProperty("thumbnail") String thumbnail,
    @JsonProperty("description") String description,
    @JsonProperty("owner_id") Long ownerId,
    @JsonProperty("category_id") Long categoryId,
    @JsonProperty("created_at") LocalDateTime createdAt,
    @JsonProperty("updated_at") LocalDateTime updatedAt,
    @JsonProperty("total_page") Integer totalPage
    //this field is for holding the total number of pages (in case query directly from database)
    //and retrieve from redis cache
) {}
