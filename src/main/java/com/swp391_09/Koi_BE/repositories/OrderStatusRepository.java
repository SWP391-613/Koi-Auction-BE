package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderStatusRepository extends JpaRepository<OrderStatus, Integer> {
}
