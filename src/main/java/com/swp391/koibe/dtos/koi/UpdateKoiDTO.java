package com.swp391.koibe.dtos.koi;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.EKoiGender;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;

public record UpdateKoiDTO(
    @JsonProperty("name")
    @NotBlank(message = "Koi name is required")
    String name,

    @NotBlank(message = "Koi status is required")
    @Pattern(regexp = "UNVERIFIED|VERIFIED|REJECTED|PENDING|SOLD", message = "Status must be either UNVERIFIED, VERIFIED, REJECTED, PENDING, SOLD")
    @JsonProperty("status_name") String trackingStatus,

    @NotNull(message = "Koi is display is required")
    @JsonProperty("is_display") Integer isDisplay,

//    @NotBlank(message = "Koi thumbnail is required")
    @JsonProperty("thumbnail") String thumbnail,

    @NotBlank(message = "Koi gender is required")
    @Pattern(regexp = "MALE|FEMALE|UNKNOWN", message = "Gender must be either MALE | FEMALE | UNKNOWN")
    @JsonProperty("sex") String sex,

    @NotNull(message = "Koi length is required")
    @Min(value = 1, message = "Koi length must be greater than 0")
    @Max(value = 1000, message = "Koi length must be less than 1000")
    @JsonProperty("length") Integer length,

    @NotNull(message = "Koi year born is required")
    @Min(value = 1, message = "Koi year born must be greater than 0")
    @JsonProperty("year_born") Integer yearBorn,

    @JsonProperty("description") String description,

    @Positive(message = "Koi category id must be greater than 0")
    @NotNull(message = "Koi category id is required")
    @JsonProperty("category_id") Long categoryId,

    @Positive(message = "Koi owner id must be greater than 0")
    @NotNull(message = "Koi owner id is required")
    @JsonProperty("owner_id") Long ownerId
) {}
