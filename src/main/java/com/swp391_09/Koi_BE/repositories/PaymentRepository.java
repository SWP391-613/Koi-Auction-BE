package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

}
