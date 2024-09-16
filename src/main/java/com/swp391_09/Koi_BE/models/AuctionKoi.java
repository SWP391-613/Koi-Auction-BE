package com.swp391_09.Koi_BE.models;

import com.swp391_09.Koi_BE.enums.BidMethod;
import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import java.time.LocalDateTime;
import java.util.List;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@Entity
@Table(name = "auction_kois")
public class AuctionKoi {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "base_price")
    @Min(0)
    private Long basePrice;

    @Column(name = "bid_time")
    private LocalDateTime bidTime;

    @Enumerated(EnumType.ORDINAL) // Prefer STRING over ORDINAL for better readability in the DB
    @Column(name = "auction_type")
    private BidMethod bidMethod;

    @ManyToOne
    @JoinColumn(name = "auction_id")
    private Auction auction;

    @ManyToOne
    @JoinColumn(name = "koi_id")
    private Koi koi;

    @OneToMany(mappedBy = "auctionKoi")
    private List<AuctionKoiDetail> auctionKoiDetails;

    // New fields
    @Column(name = "current_bid", nullable = false, columnDefinition = "int default 0")
    private int currentBid; // Track current highest bid

    @Column(name = "current_bidder_id", nullable = true) // Nullable since no bidder initially
    private Long currentBidderId; // Track the highest bidder

    @Column(name = "is_sold", nullable = false, columnDefinition = "boolean default false")
    private boolean isSold; // Track if the item has been sold

}