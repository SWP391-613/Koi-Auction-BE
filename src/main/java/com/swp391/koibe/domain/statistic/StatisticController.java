package com.swp391.koibe.domain.statistic;

import com.swp391.koibe.api.ApiResponse;
import com.swp391.koibe.domain.auction.AuctionStatusCountResponse;
import com.swp391.koibe.domain.auction.IAuctionContract;
import com.swp391.koibe.domain.koi.IKoiService;
import com.swp391.koibe.domain.koi.KoiPort;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("${api.prefix}/statistics")
@Slf4j
@RequiredArgsConstructor
@Tag(name = "Statistics", description = "APIs for managing statistics")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class StatisticController {

    IAuctionContract auctionService;
    IKoiService koiService;

    @GetMapping("/count-by-auction-status")
    public ResponseEntity<ApiResponse<AuctionStatusCountResponse>> countAuctionByStatus() {
        return ResponseEntity.ok(
            ApiResponse.<AuctionStatusCountResponse>builder()
                .message("Count auction by status successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .data(auctionService.countAuctionByStatus())
                .build()
        );
    }

    @GetMapping("/count-by-gender")
    public ResponseEntity<ApiResponse<KoiPort.KoiGenderResponse>> getQuantityKoiGender() {
        return ResponseEntity.ok(ApiResponse.<KoiPort.KoiGenderResponse>builder()
                                     .message("Koi count fetched successfully")
                                     .isSuccess(true)
                                     .statusCode(HttpStatus.OK.value())
                                     .data(koiService.findQuantityKoiByGender())
                                     .build());
    }

    @GetMapping("/count-by-status")
    public ResponseEntity<ApiResponse<KoiPort.KoiStatusResponse>> getQuantityKoiStatus() {
        return ResponseEntity.ok(ApiResponse.<KoiPort.KoiStatusResponse>builder()
                                     .message("Koi count fetched successfully")
                                     .isSuccess(true)
                                     .statusCode(HttpStatus.OK.value())
                                     .data(koiService.findQuantityKoiByStatus())
                                     .build());

    }

}
