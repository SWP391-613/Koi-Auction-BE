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
public class AuctionStatusCountResponse {

    @JsonProperty("total")
    private Integer total;

    @JsonProperty("upcoming")
    private Long upcoming;

    @JsonProperty("ongoing")
    private Long ongoing;

    @JsonProperty("ended")
    private Long ended;

}