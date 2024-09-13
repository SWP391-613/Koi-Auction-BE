package com.swp391_09.Koi_BE.services.order;

import com.swp391_09.Koi_BE.models.Order;
import com.swp391_09.Koi_BE.repositories.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderService implements IOrderService{

    private final OrderRepository orderRepository;

    @Override
    public Order createOrder(Order order) throws Exception {
        return null;
    }
}
