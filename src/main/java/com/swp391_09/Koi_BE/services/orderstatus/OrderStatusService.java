package com.swp391_09.Koi_BE.services.orderstatus;

import com.swp391_09.Koi_BE.repositories.OrderStatusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderStatusService implements IOrderStatusService {

    private final OrderStatusRepository orderStatusRepository;

}
