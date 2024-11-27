package com.swp391.koibe.repositories;

import com.swp391.koibe.enums.EPaymentStatus;
import com.swp391.koibe.models.Order;
import com.swp391.koibe.models.Payment;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

    Optional<Payment> findByOrder(Order order);
    Page<Payment> findPaymentsByUserId(Long userId, Pageable pageable);
    Page<Payment> findPaymentsByUserIdAndPaymentStatus(Long userId, EPaymentStatus status, Pageable pageable);

    @Query(
        "SELECT p FROM Payment p WHERE " +
            "(:status IS NULL OR p.paymentStatus = :status)  " +
            "AND (:keyword IS NULL OR :keyword = '' " +
            "OR p.bankNumber LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            " OR LOWER(CONCAT(p.user.firstName, ' ', p.user.lastName)) LIKE LOWER(CONCAT('%', :keyword, '%'))" +
            " OR CAST(p.id AS string) LIKE LOWER(CONCAT('%', :keyword, '%'))" +
            " OR CAST(p.paymentAmount AS string) LIKE LOWER(CONCAT('%', :keyword, '%'))" +
            " OR CAST(p.user.id AS string) LIKE LOWER(CONCAT('%', :keyword, '%')))" +
            "ORDER BY p.paymentDate DESC"
    )
    Page<Payment> findPaymentsByStatusAndKeyWord(String keyword, EPaymentStatus status, Pageable pageable);

    @Query(
        "SELECT p FROM Payment p WHERE " +
            "(:keyword IS NULL OR :keyword = '' OR " +
            "p.bankNumber LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(CONCAT(p.user.firstName, ' ', p.user.lastName)) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            " OR CAST(p.id AS string) LIKE LOWER(CONCAT('%', :keyword, '%'))" +
            " OR CAST(p.paymentAmount AS string) LIKE LOWER(CONCAT('%', :keyword, '%'))" +
            "OR CAST(p.user.id AS string) LIKE LOWER(CONCAT('%', :keyword, '%')))"
    )
    Page<Payment> findPaymentsByKeyword(String keyword, Pageable pageable);


}
