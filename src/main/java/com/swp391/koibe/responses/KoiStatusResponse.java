package com.swp391.koibe.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class KoiStatusResponse {

    @JsonProperty("total")
    private Integer total;

    @JsonProperty("unverified")
    private Long unverified;

    @JsonProperty("verified")
    private Long verified;

    @JsonProperty("rejected")
    private Long rejected;

    @JsonProperty("sold")
    private Long sold;

}
