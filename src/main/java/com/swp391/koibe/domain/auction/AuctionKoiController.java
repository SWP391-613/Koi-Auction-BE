package com.swp391.koibe.domain.auction;

import com.swp391.koibe.api.ApiResponse;
import com.swp391.koibe.api.PageResponse;
import com.swp391.koibe.components.JwtTokenUtils;
import com.swp391.koibe.constants.BusinessNumber;
import com.swp391.koibe.domain.bidding.BidMethodQuantityResponse;
import com.swp391.koibe.domain.koi.KoiInAuctionPaginationResponse;
import com.swp391.koibe.domain.koi.KoiInAuctionResponse;
import com.swp391.koibe.domain.user.IUserService;
import com.swp391.koibe.domain.user.User;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.redis.koi.IKoiRedisService;
import com.swp391.koibe.utils.DTOConverter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import java.security.Principal;
import java.util.List;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("${api.prefix}/auctionkois")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Tag(name = "Auction Koi", description = "APIs for managing auction koi")
@RequiredArgsConstructor
public class AuctionKoiController {

    IAuctionContract auctionKoiService;
    IUserService userService;
    IKoiRedisService koiRedisService;
    JwtTokenUtils jwtTokenUtils;

    @GetMapping("/count-by-bid-method")
    public ResponseEntity<BidMethodQuantityResponse> countAuctionKoiByBidMethod() {
        return ResponseEntity.ok(auctionKoiService.findQuantityByBidMethod());
    }

//    @GetMapping("/auction/{id}")
//    public ResponseEntity<List<AuctionKoiPort.AuctionKoiResponse>> getAuctionKoisByAuctionId(
//        @PathVariable Long id) {
//        try {
//            return ResponseEntity.ok(auctionKoiService.getAuctionKoiByAuctionId(id));
//        } catch (Exception e) {
//            log.error("Error getting auctionkois by auction id: {}", e.getMessage());
//            throw new DataNotFoundException();
//        }
//    }

    @GetMapping("/{aid}/{id}")
    public ResponseEntity<?> getAuctionKoiByAuctionIdAndKoiId(@PathVariable Long aid,
                                                              @PathVariable Long id) {
        try {
            return ResponseEntity.ok(auctionKoiService.getAuctionKoiByAuctionIdAndKoiId(aid, id));
        } catch (Exception e) {
            log.error("Error getting auctionkoi by auction id and koi id: {}", e.getMessage());
            throw new DataNotFoundException(
                "Error getting auctionkoi by auction id and koi id: " + e.getMessage());
        }
    }

    @GetMapping("") // /auctions/?page=1&limit=10
    public ResponseEntity<List<AuctionKoiPort.AuctionKoiResponse>> getAllAuctions(
        @RequestParam int page,
        @RequestParam int limit) {
        try {
            PageRequest pageRequest = PageRequest.of(page, limit);
            Page<AuctionKoiPort.AuctionKoiResponse> auctionKois = auctionKoiService.getAllAuctionKois(pageRequest);
            return ResponseEntity.ok(auctionKois.getContent());
        } catch (Exception e) {
            log.error("Error getting all auctionkois    : {}", e.getMessage());
            throw new DataNotFoundException(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<AuctionKoiPort.AuctionKoiResponse> getAuctionKoiDetails(@PathVariable Long id) {
        try {
            AuctionKoiPort.AuctionKoiResponse auctionKoiResponse = auctionKoiService.getAuctionKoiDetailsById(id);
            return ResponseEntity.ok(auctionKoiResponse);
        } catch (DataNotFoundException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            log.error("Error getting auctionkoi by id: {}", e.getMessage());
            throw new DataNotFoundException("Error getting auctionkoi by id: " + e.getMessage());
        }
    }

    // assign koi list to an auction
    @PostMapping("")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF', 'ROLE_BREEDER')")
    public ResponseEntity<ApiResponse<AuctionKoiPort.AuctionKoiResponse>> createAuctionKoi(
        @Valid @RequestBody AuctionKoiPort.AuctionKoiDTO auctionKoiDTO,
        Principal principal,
        BindingResult result
    ) throws Exception {
        User user = userService.findByUsername(principal.getName());

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        //check breeder account have enough money to register koi to auction
        if (user.getAccountBalance() < Math.floorDiv(auctionKoiDTO.basePrice(), BusinessNumber.FEE_ADD_KOI_TO_AUCTION)) {
            throw new MalformDataException("You dont have enough money to register Koi to Auction");
        }

        AuctionKoi newAuctionKoi = auctionKoiService.createAuctionKoi(auctionKoiDTO);
        AuctionKoiPort.AuctionKoiResponse response = DTOConverter.toAuctionKoiResponse(newAuctionKoi);

        userService.validateAccountBalance(user, auctionKoiDTO.basePrice());

        //update breeder account balance
        userService.updateAccountBalance(user.getId(), -Math.floorDiv(auctionKoiDTO.basePrice(), 10));

        return ResponseEntity.ok(
            ApiResponse.<AuctionKoiPort.AuctionKoiResponse>builder()
                .message("AuctionKoi created successfully")
                .data(response)
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
            .build());
    }

    @PutMapping("/auctionkois/{auctionkoi_id}")
    public ResponseEntity<AuctionKoiPort.AuctionKoiResponse> updateAuctionKoi(
        @PathVariable Long auctionkoi_id,
        @Valid @RequestBody UpdateAuctionKoiDTO updateAuctionKoiDTO,
        BindingResult result) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }
        AuctionKoiPort.AuctionKoiResponse updatedAuctionKoi = auctionKoiService.updateAuctionKoi(auctionkoi_id,
                                                                                  updateAuctionKoiDTO);
        return ResponseEntity.ok(updatedAuctionKoi);
    }

    @PutMapping("/revoke/koi/{koi_id}/auction/{auction_id}")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER', 'ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<ApiResponse<AuctionKoiPort.AuctionKoiResponse>> revokeKoiInAuction(
        @PathVariable Long koi_id,
        @PathVariable Long auction_id
    ) {
        auctionKoiService.revokeKoiInAuction(koi_id, auction_id);

        return ResponseEntity.ok(
            ApiResponse.<AuctionKoiPort.AuctionKoiResponse>builder()
                .message("Koi in Auction revoked successfully")
                .data(null)
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
            .build()
        );
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER', 'ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<?> deleteAuctionKoi(@PathVariable Long id) {
        auctionKoiService.deleteAuctionKoi(id);
        return ResponseEntity.ok("AuctionKoi deleted successfully");
    }

    @GetMapping("/get-kois-by-keyword")
    public ResponseEntity<PageResponse<KoiInAuctionResponse>> getKoisByKeyword(
        @RequestParam(defaultValue = "", required = false) String keyword,
        @RequestParam(defaultValue = "0", required = false) int page,
        @RequestParam(defaultValue = "10", required = false) int limit
    ) throws Exception {
        PageRequest pageRequest = PageRequest.of(
            page, limit,
            Sort.by("id").ascending()
        );

        Page<KoiInAuctionResponse> koiPage = auctionKoiService.getKoiByKeyword(keyword, pageRequest);
        PageResponse<KoiInAuctionResponse> response = KoiInAuctionPaginationResponse.fromPage(koiPage, pageRequest);

        return ResponseEntity.ok(response);
    }

}