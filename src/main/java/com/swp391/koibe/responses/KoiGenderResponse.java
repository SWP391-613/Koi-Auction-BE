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
public class KoiGenderResponse {

    @JsonProperty("total")
    private Integer total;

    @JsonProperty("male")
    private Long male;

    @JsonProperty("female")
    private Long female;

    @JsonProperty("unknown")
    private Long unknown;

}
