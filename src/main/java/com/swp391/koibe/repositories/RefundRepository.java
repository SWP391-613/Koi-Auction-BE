package com.swp391.koibe.repositories;

import com.swp391.koibe.domain.payment.Refund;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RefundRepository extends JpaRepository<Refund, Long> {

}
