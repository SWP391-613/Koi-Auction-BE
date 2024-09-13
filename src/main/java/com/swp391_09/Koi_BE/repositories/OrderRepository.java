package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {

}
