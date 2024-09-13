package com.swp391_09.Koi_BE.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391_09.Koi_BE.enums.TrackingStatus;
import lombok.Builder;

@Builder
public class KoiDTO {

    @JsonProperty("name")
    private String name;

    @JsonProperty("price")
    private Float price;

    @JsonProperty("tracking_status")
    private TrackingStatus trackingStatus;

    @JsonProperty("is_display")
    private int isDisplay;

    @JsonProperty("is_sold")
    private int isSold;

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

}
