package com.swp391.koibe.domain.user;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.api.BasePaginationResponse;
import com.swp391.koibe.domain.user.UserPort.BreederResponse;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BreederPaginationResponse extends BasePaginationResponse {

    @JsonProperty("item")
    private List<BreederResponse> item;
}
