package com.swp391.koibe.repositories;

import com.swp391.koibe.models.Bid;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BidHistoryRepository extends JpaRepository<Bid, Long> {

    Boolean existsByAuctionKoiIdAndBidderId(Long auctionKoiId, Long bidderId);
    List<Bid> getAllByAuctionKoiId(Long auctionKoiId);

}
