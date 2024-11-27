package com.swp391.koibe.repositories

import com.swp391.koibe.models.AuctionKoi
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query

interface AuctionKoiRepository : JpaRepository<AuctionKoi, Long> {
    fun findAuctionKoiByAuctionId(auctionId: Long): List<AuctionKoi>
    fun existsByKoiIdAndAuctionId(koiId: Long, auctionId: Long): Boolean

    @Modifying
    @Query("UPDATE AuctionKoi a SET a.revoked = 1 WHERE a.id = :id")
    fun softDeleteById(id: Long)
}
