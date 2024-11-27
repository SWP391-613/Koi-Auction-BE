package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public record KoiStatusResponse(
    @JsonProperty("total") Integer total,
    @JsonProperty("unverified") Long unverified,
    @JsonProperty("verified") Long verified,
    @JsonProperty("rejected") Long rejected,
    @JsonProperty("sold") Long sold
) {

}
