package com.swp391.koibe.domain.auction;

import com.swp391.koibe.api.PageResponse;
import com.swp391.koibe.domain.auction.AuctionKoiPort.AuctionKoiResponse;
import com.swp391.koibe.domain.bidding.BidMethodQuantityResponse;
import com.swp391.koibe.domain.koi.KoiInAuctionResponse;
import com.swp391.koibe.domain.user.UserPort.UserResponse;
import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import jakarta.mail.MessagingException;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IAuctionContract {

    //Auction
    AuctionResponse createAscendingAuction(AuctionPort.AuctionDTO auctionDTO) throws DataAlreadyExistException;

    AuctionResponse getAuctionById(long id) throws DataNotFoundException;

    AuctionResponse update(long auctionId, UpdateAuctionDTO updateAuctionDTO) throws DataNotFoundException;

    void delete(long id);

    void end(long id) throws DataNotFoundException;

    List<Auction> getAuctionByStatus(EAuctionStatus status);

    boolean updateAuctionStatus(Auction auction) throws DataNotFoundException;

    Set<Auction> getAuctionOnStatus(EAuctionStatus status);

    List<AuctionResponse> getAuctionByAuctioneerId(long auctioneerId) throws DataNotFoundException;

    PageResponse<AuctionResponse> getAuctionByKeyword(String keyword, EAuctionStatus status, Pageable pageable);

    AuctionStatusCountResponse countAuctionByStatus();

    //AuctionKoi
    AuctionKoi createAuctionKoi(AuctionKoiPort.AuctionKoiDTO auctionKoiDTO)
        throws DataNotFoundException, MessagingException;

    AuctionKoi getAuctionKoiById(long id) throws DataNotFoundException;

    List<AuctionKoiPort.AuctionKoiResponse> getAuctionKoiByAuctionId(long id);

    Page<AuctionKoiResponse> getAllAuctionKois(Pageable pageable);

    AuctionKoiPort.AuctionKoiResponse updateAuctionKoi(long auctionKoiId, UpdateAuctionKoiDTO updateAuctionKoiDTO);

    void deleteAuctionKoi(long id);

    AuctionKoiPort.AuctionKoiResponse getAuctionKoiDetailsById(long id) throws DataNotFoundException;

    AuctionKoiPort.AuctionKoiResponse getAuctionKoiByAuctionIdAndKoiId(long aid, long id)
        throws DataNotFoundException;

    boolean updateAuctionKoiStatus(long auctionKoiId, AuctionKoi auctionKoi);

    List<AuctionKoi> getAuctionKoiByAuctionIdV2(long id);

    void updateDescendAuctionKoiPrice(long auctionKoiId, AuctionKoi auctionKoi);

    void revokeKoiInAuction(long koiId, long auctionId);

    Page<KoiInAuctionResponse> getKoiByKeyword(String keyword, Pageable pageable);

    BidMethodQuantityResponse findQuantityByBidMethod();

    boolean findKoiInAuction(long koiId);

    void revokeKoiInAuction(long koiId);

    //AuctionParticipant
    AuctionParticipant createAuctionParticipant(AuctionParticipant auctionParticipant);
    AuctionParticipant getAuctionParticipantById(long id);
    AuctionParticipant updateAuctionParticipant(long id, AuctionParticipant auctionParticipant);
    void deleteAuctionParticipant(long id);
    Boolean hasJoinedAuction(long auctionId, long userId);
    Set<UserResponse> getAllUserJoinAuction(long auctionId) throws DataNotFoundException; // get all user who are bidding in a specific auction

}
