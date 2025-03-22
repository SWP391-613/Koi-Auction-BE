package com.swp391.koibe.domain.auction;

import com.swp391.koibe.domain.koi.KoiInAuctionResponse;
import com.swp391.koibe.domain.koi.KoiPort;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import jakarta.mail.MessagingException;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IAuctionKoiService {

    AuctionKoi createAuctionKoi(AuctionKoiPort.AuctionKoiDTO auctionKoiDTO)
        throws DataNotFoundException, MessagingException;

    AuctionKoi getAuctionKoiById(long id) throws DataNotFoundException;

    List<AuctionKoiPort.AuctionKoiResponse> getAuctionKoiByAuctionId(long id);

    Page<AuctionKoiPort.AuctionKoiResponse> getAllAuctionKois(Pageable pageable);

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

}
