package com.swp391_09.Koi_BE.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name="auction_kois_details")
public class AuctionKoiDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int bidStep; // Optional, if you want to enforce bid increments
    private LocalDateTime bidTime; // Track when the bid was placed

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User bidder; // Track who placed the bid

    @ManyToOne
    @JoinColumn(name = "auction_koi_id")
    private AuctionKoi auctionKoi;

}
