package com.swp391.koibe.repositories;

import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.models.Auction;
import io.lettuce.core.dynamic.annotation.Param;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface AuctionRepository extends JpaRepository<Auction, Long> {

    List<Auction> findAllByStatus(EAuctionStatus status);

    Set<Auction> findAuctionsByStatus(EAuctionStatus status);

    List<Auction> findAuctionByAuctioneerId(Long auctioneerId);

    @Query("SELECT a FROM Auction a WHERE " +
        "a.title LIKE CONCAT('%', :keyword, '%')" +
        "OR CAST(a.status as string) LIKE CONCAT('%', :keyword, '%') " +
        "OR CAST(a.startTime as string) LIKE CONCAT('%', :keyword, '%') " +
        "OR CAST(a.endTime as string) LIKE CONCAT('%', :keyword, '%') ")
    Page<Auction> getAuctionByKeyword(@Param("keyword") String keyword, Pageable pageable);

    @Query("SELECT a FROM Auction a WHERE " +
        "(a.title LIKE CONCAT('%', :keyword, '%') " +
        "OR CAST(a.startTime as string) LIKE CONCAT('%', :keyword, '%') " +
        "OR CAST(a.endTime as string) LIKE CONCAT('%', :keyword, '%')) " +
        "AND a.status = :status")
    Page<Auction> getAuctionUpcomingByKeyword(
        @Param("keyword") String keyword,
        @Param("status") EAuctionStatus status,
        Pageable pageable);

    @Query("SELECT COUNT(a) FROM Auction a WHERE a.auctioneer.id = :auctioneer_id")
    Long countAuctionsByAuctioneerId(Long auctioneer_id);
}
