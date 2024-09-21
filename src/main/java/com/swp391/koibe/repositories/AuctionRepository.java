package com.swp391.koibe.repositories;

import com.swp391.koibe.models.Auction;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuctionRepository extends JpaRepository<Auction, Long> {

}
