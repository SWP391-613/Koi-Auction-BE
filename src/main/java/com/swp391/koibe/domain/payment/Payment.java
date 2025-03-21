package com.swp391.koibe.domain.payment;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.domain.order.Order;
import com.swp391.koibe.enums.EPaymentStatus;
import com.swp391.koibe.enums.EPaymentType;
import com.swp391.koibe.domain.user.User;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "payments")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Payment {

    @Id
    @SequenceGenerator(name = "payments_seq", sequenceName = "payments_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "payments_seq")
    @Column(name="id", unique=true, nullable=false)
    @JsonProperty("id")
    private Long id;

    @Column(name = "payment_amount", nullable = false)
    private Float paymentAmount;

    @Column(name = "payment_date", nullable = false)
    private LocalDateTime paymentDate;

    @Column(name = "payment_method", nullable = false)
    private String paymentMethod;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status", nullable = false)
    private EPaymentStatus paymentStatus; // e.g., SUCCESS, PENDING, REFUNDED

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_type", nullable = false)
    private EPaymentType paymentType; // e.g., 'DEPOSIT', 'ORDER', 'DRAW_OUT'

    @Column(name = "bank_number")
    private String bankNumber;

    @Column(name = "bank_name")
    private String bankName;
    
    // Track refunds related to this payment
//    @OneToMany(mappedBy = "payment", cascade = CascadeType.ALL)
//    private List<Refund> refunds;

    // Calculate total refunded amount
//    public Float getTotalRefundedAmount() {
//        return refunds.stream()
//            .map(Refund::getRefundAmount)
//            .reduce(0.0f, Float::sum);
//    }
//
//    // Check if the payment is refundable
//    public boolean isRefundable(Float refundAmount) {
//        return paymentAmount >= getTotalRefundedAmount() + refundAmount;
//    }
}

