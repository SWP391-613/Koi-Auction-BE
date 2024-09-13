package com.swp391_09.Koi_BE.services.orderdetail;

import com.swp391_09.Koi_BE.repositories.OrderDetailRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderDetailService implements IOrderDetailService{

    private final OrderDetailRepository orderDetailRepository;

    @Override
    public void createOrderDetail(int orderId, int productId, int quantity) throws Exception {

    }

    @Override
    public void updateOrderDetail(int id, int orderId, int productId, int quantity)
        throws Exception {

    }

    @Override
    public void deleteOrderDetail(int id) throws Exception {

    }

    @Override
    public void getOrderDetail(int id) throws Exception {

    }

    @Override
    public void getOrderDetails() throws Exception {

    }
}
