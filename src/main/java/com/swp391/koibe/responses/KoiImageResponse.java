package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(Include.NON_NULL)
public record KoiImageResponse(
    @JsonProperty("id") Long id,
    @JsonProperty("koi_id") Long koiId,
    @JsonProperty("image_url") String imageUrl,
    @JsonProperty("video_url") String videoUrl
) {}
