package com.swp391_09.Koi_BE.services.order;

import com.swp391_09.Koi_BE.models.Order;

public interface IOrderService {

    Order createOrder(Order order) throws Exception;

}
