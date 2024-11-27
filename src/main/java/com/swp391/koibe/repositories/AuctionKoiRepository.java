package com.swp391.koibe.repositories;

import com.swp391.koibe.models.AuctionKoi;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface AuctionKoiRepository extends JpaRepository<AuctionKoi, Long> {
    List<AuctionKoi> findAuctionKoiByAuctionId(Long auctionId);

    @Modifying
    @Query("UPDATE AuctionKoi a SET a.revoked = 1 WHERE a.id = :id")
    void softDeleteById(Long id);
}
