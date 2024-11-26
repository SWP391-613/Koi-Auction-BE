package com.swp391.koibe.repositories

import com.swp391.koibe.models.AuctionKoi
import org.springframework.data.jpa.repository.JpaRepository

interface AuctionKoiRepository : JpaRepository<AuctionKoi, Long> {
    fun findAuctionKoiByAuctionId(auctionId: Long): List<AuctionKoi>
    fun existsByKoiIdAndAuctionId(koiId: Long, auctionId: Long): Boolean
}
