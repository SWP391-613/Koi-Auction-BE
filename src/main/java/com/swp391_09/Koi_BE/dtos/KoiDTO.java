package com.swp391_09.Koi_BE.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391_09.Koi_BE.enums.KoiTrackingStatus;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class KoiDTO {

    @JsonProperty("name")
    private String name;

    @JsonProperty("price")
    private Float price;

    @JsonProperty("tracking_status")
    private KoiTrackingStatus koiTrackingStatus;

    @JsonProperty("is_display")
    private int isDisplay;

    @JsonProperty("thumbnail")
    private String thumbnail;

    @JsonProperty("sex")
    private String sex;

    @JsonProperty("length")
    private int length;

    @JsonProperty("age")
    private int age;

    @JsonProperty("description")
    private String description;

    @JsonProperty("category_id")
    private int categoryId;

    @JsonProperty("user_id")
    private Long ownerId;

}
