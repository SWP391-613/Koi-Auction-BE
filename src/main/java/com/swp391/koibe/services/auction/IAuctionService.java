package com.swp391.koibe.services.auction;

import com.swp391.koibe.dtos.AuctionDTO;
import com.swp391.koibe.dtos.UpdateAuctionDTO;
import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.Auction;
import com.swp391.koibe.responses.AuctionResponse;
import com.swp391.koibe.responses.AuctionStatusCountResponse;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IAuctionService {

    Auction createAscendingAuction(AuctionDTO auctionDTO) throws DataAlreadyExistException;

    AuctionResponse getById(long id) throws DataNotFoundException;

    Auction findAuctionById(long id) throws DataNotFoundException;

    Page<AuctionResponse> getAllAuctions(Pageable pageable);

    Auction update(long auctionId, UpdateAuctionDTO updateAuctionDTO) throws DataNotFoundException;

    void delete(long id);

    void end(long id) throws DataNotFoundException;

    List<Auction> getAllAuctions();

    List<Auction> getAuctionByStatus(EAuctionStatus status);

    Page<AuctionResponse> getAuctionByStatus(EAuctionStatus status, Pageable pageable);

    boolean updateAuctionStatus(Auction auction) throws DataNotFoundException;

    Set<Auction> getAuctionOnCondition(String condition);

    Set<Auction> getAuctionOnStatus(EAuctionStatus status);

    List<Auction> getAuctionByAuctioneerId(long auctioneerId) throws DataNotFoundException;

    Page<Auction> getAuctionByKeyword(String keyword, Pageable pageable);

    Page<Auction> getAuctionUpcomingByKeyword(String keyword, EAuctionStatus status,
                                              Pageable pageable);

    AuctionStatusCountResponse countAuctionByStatus();
}
