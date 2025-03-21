package com.swp391.koibe.dtos.responses.pagination;

import com.swp391.koibe.dtos.responses.PaymentResponse;
import com.swp391.koibe.api.BasePaginationResponse;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
public class PaymentPaginationResponse extends BasePaginationResponse {
    private List<PaymentResponse> item;
}
