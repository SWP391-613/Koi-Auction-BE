package com.swp391.koibe.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "wallets")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Wallet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "balance", nullable = false)
    private Float balance;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // Deduct balance
    public void deductBalance(Float amount) {
        if (balance < amount) {
            throw new IllegalArgumentException("Insufficient funds");
        }
        balance -= amount;
    }

    // Add balance
    public void addBalance(Float amount) {
        balance += amount;
    }
}

