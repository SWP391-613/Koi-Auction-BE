package com.swp391.koibe.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.EBidMethod;
import com.swp391.koibe.models.listener.AuctionKoiListener;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@Entity
@Table(name = "auction_kois")
//@EntityListeners(AuctionKoiListener.class)
public class AuctionKoi {

    @Id
    @SequenceGenerator(name = "auction_kois_seq", sequenceName = "auction_kois_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "auction_kois_seq")
    @Column(name="id", unique=true, nullable=false)
    @JsonProperty("id")
    private Long id;

    @Column(name = "ceil_price")
    private Long ceilPrice;

    @Column(name = "base_price")
    @Min(0)
    private Long basePrice;

    @Column(name = "bid_step", columnDefinition = "BIGINT default 0")
    private long bidStep; // Track the bid step

    @Enumerated(EnumType.STRING)
    @Column(name = "bid_method")
    private EBidMethod bidMethod;

    @Column(name = "is_sold", nullable = false, columnDefinition = "boolean default false")
    private boolean isSold; // Track if the item has been sold

    // New fields
    @Column(name = "current_bid")
    private Long currentBid; // Track current highest bid

    @Column(name = "current_bidder_id") // Nullable since no bidder initially
    private Long currentBidderId; // Track the highest bidder

    @Column(name = "revoked", nullable = false, columnDefinition = "int default 0")
    private int revoked; // Track if the item has been revoked

    @ManyToOne
    @JoinColumn(name = "auction_id")
    private Auction auction;

    @ManyToOne
    @JoinColumn(name = "koi_id")
    private Koi koi;

//    @OneToMany(mappedBy = "auctionKoi")
//    private List<BidHistory> bidHistories;

}