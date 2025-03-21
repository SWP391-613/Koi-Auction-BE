package com.swp391.koibe.domain.auction;

import com.swp391.koibe.dtos.auctionkoi.AuctionKoiDTO;
import com.swp391.koibe.dtos.auctionkoi.UpdateAuctionKoiDTO;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.dtos.responses.AuctionKoiResponse;
import com.swp391.koibe.dtos.responses.BidMethodQuantityResponse;
import com.swp391.koibe.dtos.responses.KoiInAuctionResponse;
import jakarta.mail.MessagingException;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IAuctionKoiService {

    AuctionKoi createAuctionKoi(AuctionKoiDTO auctionKoiDTO)
        throws DataNotFoundException, MessagingException;

    AuctionKoi getAuctionKoiById(long id) throws DataNotFoundException;

    List<AuctionKoiResponse> getAuctionKoiByAuctionId(long id);

    Page<AuctionKoiResponse> getAllAuctionKois(Pageable pageable);

    AuctionKoiResponse updateAuctionKoi(long auctionKoiId, UpdateAuctionKoiDTO updateAuctionKoiDTO);

    void deleteAuctionKoi(long id);

    AuctionKoiResponse getAuctionKoiDetailsById(long id) throws DataNotFoundException;

    AuctionKoiResponse getAuctionKoiByAuctionIdAndKoiId(long aid, long id)
        throws DataNotFoundException;

    boolean updateAuctionKoiStatus(long auctionKoiId, AuctionKoi auctionKoi);

    List<AuctionKoi> getAuctionKoiByAuctionIdV2(long id);

    void updateDescendAuctionKoiPrice(long auctionKoiId, AuctionKoi auctionKoi);

    void revokeKoiInAuction(long koiId, long auctionId);

    Page<KoiInAuctionResponse> getKoiByKeyword(String keyword, Pageable pageable);

    BidMethodQuantityResponse findQuantityByBidMethod();

    boolean findKoiInAuction(long koiId);

    void revokeKoiInAuction(long koiId);

}
