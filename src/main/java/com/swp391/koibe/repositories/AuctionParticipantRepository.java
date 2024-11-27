package com.swp391.koibe.repositories;

import com.swp391.koibe.models.AuctionParticipant;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuctionParticipantRepository extends JpaRepository<AuctionParticipant, Long> {
    AuctionParticipant getAuctionParticipantByAuctionIdAndUserId(Long auctionId, Long userId);
    List<AuctionParticipant> getAuctionParticipantsByAuctionId(Long auctionId);
}
