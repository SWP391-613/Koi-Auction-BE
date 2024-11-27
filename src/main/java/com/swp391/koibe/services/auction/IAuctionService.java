package com.swp391.koibe.services.auction;

import com.swp391.koibe.dtos.AuctionDTO;
import com.swp391.koibe.dtos.UpdateAuctionDTO;
import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.Auction;
import com.swp391.koibe.responses.AuctionResponse;
import com.swp391.koibe.responses.AuctionStatusCountResponse;
import com.swp391.koibe.responses.base.PageResponse;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IAuctionService {

    AuctionResponse createAscendingAuction(AuctionDTO auctionDTO) throws DataAlreadyExistException;

    AuctionResponse getById(long id) throws DataNotFoundException;

    AuctionResponse findAuctionById(long id) throws DataNotFoundException;

    PageResponse<AuctionResponse> getAllAuctions(Pageable pageable);

    AuctionResponse update(long auctionId, UpdateAuctionDTO updateAuctionDTO) throws DataNotFoundException;

    void delete(long id);

    void end(long id) throws DataNotFoundException;

    List<Auction> getAuctionByStatus(EAuctionStatus status);

    Page<AuctionResponse> getAuctionByStatus(EAuctionStatus status, Pageable pageable);

    boolean updateAuctionStatus(Auction auction) throws DataNotFoundException;

    Set<Auction> getAuctionOnStatus(EAuctionStatus status);

    List<AuctionResponse> getAuctionByAuctioneerId(long auctioneerId) throws DataNotFoundException;

    PageResponse<AuctionResponse> getAuctionByKeyword(String keyword, Pageable pageable);

    PageResponse<AuctionResponse> getAuctionUpcomingByKeyword(String keyword, EAuctionStatus status,
                                              Pageable pageable);

    AuctionStatusCountResponse countAuctionByStatus();
}
