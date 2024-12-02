package com.swp391.koibe.repositories;

import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.models.Koi;
import com.swp391.koibe.responses.KoiInAuctionResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface KoiRepository extends JpaRepository<Koi, Long> {

    @Query("SELECT k FROM Koi k WHERE k.owner.id = :ownerId AND k.isDisplay = 1")
    Page<Koi> findByOwnerId(@Param("ownerId") Long ownerId, Pageable pageable);

    Page<Koi> findByOwnerIdAndStatus(@Param("ownerId") Long ownerId, @Param("status") EKoiStatus status,
            Pageable pageable);

    Page<Koi> findByStatus(@Param("status") EKoiStatus status, Pageable pageable);

    @Query("SELECT k FROM Koi k WHERE k.isDisplay = 1")
    Page<Koi> findAllKoiByIsDisplayIsTrue(Pageable pageable);

    @Query("SELECT COUNT(k) FROM Koi k WHERE k.owner.id = :ownerId AND k.isDisplay = 1")
    Long countKoisByOwnerId(@Param("ownerId") Long ownerId);

    @Query("SELECT COUNT(k) FROM Koi k WHERE k.category.id = :categoryId AND k.isDisplay = 1")
    Long countKoisByCategoryId(@Param("categoryId") Long categoryId);

    @Modifying
    @Query("UPDATE Koi k SET k.isDisplay = 0 WHERE k.id = :id")
    void softDeleteKoi(@Param("id") Long id);

    @Query("SELECT new com.swp391.koibe.responses.KoiInAuctionResponse(k.id, k.name, k.sex, k.length, k.yearBorn, k.price, k.status, k.isDisplay, k.thumbnail, k.description, k.owner.id, k.category.id, k.createdAt, k.updatedAt, ak.auction.id, ak.bidMethod) "
            +
            "FROM Koi k INNER JOIN AuctionKoi ak ON k.id = ak.koi.id " +
            "INNER JOIN Auction a ON ak.auction.id = a.id " +
            "WHERE (k.status = 'VERIFIED') AND (k.isDisplay = 1) " +
            "AND (a.status IN (com.swp391.koibe.enums.EAuctionStatus.UPCOMING, com.swp391.koibe.enums.EAuctionStatus.ONGOING)) "
            +
            "AND (:keyword IS NULL OR :keyword = '' OR " +
            "k.name LIKE CONCAT('%', :keyword, '%') " +
            "OR k.description LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.sex as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.length AS string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.yearBorn AS string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.owner.firstName as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.owner.lastName as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(CONCAT(k.owner.firstName, ' ', k.owner.lastName) as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(ak.basePrice AS string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(ak.ceilPrice AS string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(ak.bidMethod as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(ak.bidStep as string) LIKE CONCAT('%', :keyword, '%'))")
    Page<KoiInAuctionResponse> findByKeyword(@Param("keyword") String keyword, Pageable pageable);

    @Query("SELECT k FROM Koi k WHERE (k.owner.id = :breederId) " +
            "AND (k.isDisplay = 1) AND ((k.name LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.sex as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.length as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.yearBorn as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.price as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR k.description LIKE CONCAT('%', :keyword, '%') " +
            "OR k.category.name LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.status as string) LIKE CONCAT('%', :keyword, '%')))")
    Page<Koi> findKoiByKeyword(@Param("keyword") String keyword, @Param("breederId") Long breederId, Pageable pageable);

    @Query("SELECT k FROM Koi k WHERE k.status = 'UNVERIFIED' " +
            "AND (k.isDisplay = 1) AND ((k.name LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.sex as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.length as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.yearBorn as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.price as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR k.description LIKE CONCAT('%', :keyword, '%') " +
            "OR k.category.name LIKE CONCAT('%', :keyword, '%')))")
    Page<Koi> findUnverifiedKoiByKeyword(@Param("keyword") String keyword, Pageable pageable);

    @Query("SELECT k FROM Koi k WHERE (k.name LIKE CONCAT('%', :keyword, '%') " +
            "OR k.description LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.sex as string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.length AS string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.yearBorn AS string) LIKE CONCAT('%', :keyword, '%') " +
            "OR CAST(k.price AS string) LIKE CONCAT('%', :keyword, '%') " +
            "OR k.category.name LIKE CONCAT('%', :keyword, '%'))")
    Page<Koi> findAllKoiByKeyword(@Param("keyword") String keyword, Pageable pageable);

    @Query("""
            SELECT DISTINCT k FROM Koi k
                LEFT JOIN AuctionKoi ak ON k.id = ak.koi.id
                LEFT JOIN Auction a ON ak.auction.id = a.id
                WHERE k.owner.id = :ownerId AND k.status = 'VERIFIED'
                    AND NOT EXISTS (
                        SELECT 1 FROM AuctionKoi ak2
                        INNER JOIN Auction a2 ON ak2.auction.id = a2.id
                        WHERE ak2.koi.id = k.id
                        AND a2.status IN (com.swp391.koibe.enums.EAuctionStatus.UPCOMING, com.swp391.koibe.enums.EAuctionStatus.ONGOING)
                    )
            """)
    Page<Koi> findByOwnerIdAndStatusAndAuctionIsNull(@Param("ownerId") Long ownerId, Pageable pageable);

}
