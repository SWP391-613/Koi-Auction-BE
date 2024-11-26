package com.swp391.koibe.repositories

import com.swp391.koibe.enums.EAuctionStatus
import com.swp391.koibe.models.Auction
import io.qameta.allure.Param
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface AuctionRepository : JpaRepository<Auction, Long> {
    fun findAllByStatus(status: EAuctionStatus): List<Auction>
    fun findAuctionsByStatus(status: EAuctionStatus): Set<Auction>
    fun findAuctionByAuctioneerId(auctioneerId: Long): List<Auction>

    @Query("SELECT a FROM Auction a WHERE " +
            "a.title LIKE CONCAT('%', :keyword, '%')" +
            "OR CAST(a.status as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(a.startTime as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(a.endTime as string) LIKE CONCAT('%', :keyword, '%') ")
    fun getAuctionByKeyword(@Param("keyword") keyword: String, pageable: Pageable): Page<Auction>

    @Query("SELECT a FROM Auction a WHERE " +
            "(a.title LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(a.startTime as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(a.endTime as string) LIKE CONCAT('%', :keyword, '%')) " +
            "AND a.status = :status")
    fun getAuctionUpcomingByKeyword(@Param("keyword") keyword: String,
                                    @Param("status") status: EAuctionStatus,
                                    pageable: Pageable): Page<Auction>

    @Query("SELECT COUNT(a) FROM Auction a WHERE a.auctioneer.id = :auctioneer_id")
    fun countAuctionsByAuctioneerId(auctioneer_id: Long): Long

}
