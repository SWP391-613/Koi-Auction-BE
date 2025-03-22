package com.swp391.koibe.domain.order;

import com.swp391.koibe.api.BasePaginationResponse;
import lombok.*;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
public class OrderPaginationResponse extends BasePaginationResponse {
        private List<OrderResponse> item;
}
