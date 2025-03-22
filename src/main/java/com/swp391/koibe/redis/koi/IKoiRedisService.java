package com.swp391.koibe.redis.koi;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.swp391.koibe.domain.koi.KoiPort;
import java.util.List;
import org.springframework.data.domain.PageRequest;

public interface IKoiRedisService {
    //Clear cached data in Redis
    void clear();

    //@GetMapping("/get-kois-by-keyword")
    List<KoiPort.KoiInAuctionResponse> findKoiInAuctionByKeyword(
        String keyword,
        PageRequest pageRequest
    ) throws JsonProcessingException;

    void saveAllKoiFindInAuctionByKeyword(
        List<KoiPort.KoiInAuctionResponse> productResponses,
        String keyword,
        PageRequest pageRequest
    ) throws JsonProcessingException;

    //@GetMapping("/get-kois-owner-by-keyword-not-auth")
    List<KoiPort.KoiResponse> findKoiByKeyword(
        String keyword,
        Long breederId,
        PageRequest pageRequest
    ) throws JsonProcessingException;

    void saveAllKois(
        List<KoiPort.KoiResponse> productResponses,
        String keyword,
        Long breederId,
        PageRequest pageRequest
    ) throws JsonProcessingException;

}
