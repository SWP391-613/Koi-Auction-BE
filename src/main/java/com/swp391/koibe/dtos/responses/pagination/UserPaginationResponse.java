package com.swp391.koibe.dtos.responses.pagination;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.dtos.responses.UserResponse;
import com.swp391.koibe.api.BasePaginationResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserPaginationResponse extends BasePaginationResponse {

    @JsonProperty("item")
    private List<UserResponse> item; // List of users
}
