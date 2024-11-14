package com.swp391.koibe.repositories

import com.swp391.koibe.enums.EKoiStatus
import com.swp391.koibe.models.Koi
import com.swp391.koibe.responses.KoiInAuctionResponse
import com.swp391.koibe.responses.KoiResponse
import com.swp391.koibe.responses.pagination.KoiPaginationResponse
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param

interface KoiRepository : JpaRepository<Koi, Long> {
    fun existsByName(name: String): Boolean
    fun findByOwnerId(ownerId: Long, pageable: Pageable): Page<Koi>
    fun findByOwnerIdAndStatus(ownerId: Long, status: EKoiStatus, pageable: Pageable): Page<Koi>
    fun findByStatus(status: EKoiStatus, pageable: Pageable): Page<Koi>

    //SELECT koi data is display in existing auction
    //notice im want to retrieve the auction id at that last column to use in fe call
    @Query(
        "SELECT new com.swp391.koibe.responses.KoiInAuctionResponse(k.id, k.name, k.sex, k.length, k.yearBorn, k.price, k.status, k.isDisplay, k.thumbnail, k.description, k.owner.id, k.category.id, k.createdAt, k.updatedAt, ak.auction.id, ak.bidMethod) " +
                "FROM Koi k INNER JOIN AuctionKoi ak ON k.id = ak.koi.id " +
                "WHERE (k.status = 'VERIFIED') AND (k.isDisplay = 1) AND " +
                "(:keyword IS NULL OR :keyword = '' OR " +
                "k.name LIKE CONCAT('%', :keyword, '%') " +
                "OR k.description LIKE CONCAT('%', :keyword, '%') " +
                "OR k.sex LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.length AS string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.yearBorn AS string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.owner.firstName as string) LIKE CONCAT('%', :keyword, '%')" +
                "OR CAST(k.owner.lastName as string) LIKE CONCAT('%', :keyword, '%')" +
                "OR CAST(CONCAT(k.owner.firstName, ' ', k.owner.lastName) as string) LIKE CONCAT('%', :keyword, '%')" +
                "OR CAST(ak.basePrice AS string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(ak.ceilPrice AS string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(ak.bidMethod as string) LIKE CONCAT('%', :keyword, '%')" +
                "OR CAST(ak.bidStep as string) LIKE CONCAT('%', :keyword, '%'))"
    )
    fun findByKeyword(
        @Param("keyword") keyword: String,
        pageable: Pageable
    ): Page<KoiInAuctionResponse>

    @Query(
        "SELECT k FROM Koi k WHERE (k.owner.id = :breederId) " +
                "AND (k.isDisplay = 1) AND ((k.name LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.sex as string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.length as string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.yearBorn as string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.price as string) LIKE CONCAT('%', :keyword, '%') " +
                "OR k.description LIKE CONCAT('%', :keyword, '%') " +
                "OR k.category.name LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.status as string) LIKE CONCAT('%', :keyword, '%')))"
    )
    fun findKoiByKeyword(
        @Param("keyword") keyword: String,
        @Param("breederId") breederId: Long,
        pageable: Pageable
    ): Page<Koi>

    @Query(
        "SELECT k FROM Koi k WHERE k.status = 'UNVERIFIED' " +
                "AND (k.isDisplay = 1) AND ((k.name LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.sex as string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.length as string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.yearBorn as string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.price as string) LIKE CONCAT('%', :keyword, '%') " +
                "OR k.description LIKE CONCAT('%', :keyword, '%') " +
                "OR k.category.name LIKE CONCAT('%', :keyword, '%')))"
    )
    fun findUnverifiedKoiByKeyword(keyword: String, pageable: Pageable): Page<Koi>

    @Query(
        "SELECT k FROM Koi k WHERE (k.name LIKE CONCAT('%', :keyword, '%') " +
                "OR k.description LIKE CONCAT('%', :keyword, '%') " +
                "OR k.sex LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.length AS string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.yearBorn AS string) LIKE CONCAT('%', :keyword, '%') " +
                "OR CAST(k.price AS string) LIKE CONCAT('%', :keyword, '%') " +
                "OR k.category.name LIKE CONCAT('%', :keyword, '%'))"
    )
    fun findAllKoiByKeyword(keyword: String, pageable: Pageable): Page<Koi>

}
