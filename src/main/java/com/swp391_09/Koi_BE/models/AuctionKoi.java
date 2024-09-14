package com.swp391_09.Koi_BE.models;

import com.swp391_09.Koi_BE.enums.AuctionType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import java.time.LocalDateTime;
import java.util.List;
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
public class AuctionKoi {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="base_price")
    @Min(0)
    private Long basePrice;

    @Column(name="bid_time")
    private LocalDateTime bidTime;

    @Enumerated(EnumType.ORDINAL)
    @Column(name="auction_type")
    private AuctionType auctionType;

    @OneToMany
    private List<Koi> koi;

    @OneToMany
    private List<Auction> auctions;

}
