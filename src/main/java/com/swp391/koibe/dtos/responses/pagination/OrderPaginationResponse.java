package com.swp391.koibe.dtos.responses.pagination;

import com.swp391.koibe.api.BasePaginationResponse;
import com.swp391.koibe.dtos.responses.order.OrderResponse;
import lombok.*;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
public class OrderPaginationResponse extends BasePaginationResponse {
        private List<OrderResponse> item;
}
