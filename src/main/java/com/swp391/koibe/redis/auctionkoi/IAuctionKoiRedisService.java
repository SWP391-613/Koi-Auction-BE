package com.swp391.koibe.redis.auctionkoi;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.swp391.koibe.dtos.responses.AuctionKoiResponse;
import java.util.List;
import org.springframework.data.domain.PageRequest;

public interface IAuctionKoiRedisService {
    //Clear cached data in Redis
    void clear();
    List<AuctionKoiResponse> getAllAuctionKois(
            String keyword,
            Integer bidMethod, PageRequest pageRequest) throws JsonProcessingException;
    void saveAllAuctionKois(List<AuctionKoiResponse> auctionKoiResponses,
                                String keyword,
                                Integer bidMethod,
                                PageRequest pageRequest) throws JsonProcessingException;

}
