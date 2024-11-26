package com.swp391.koibe.controllers;

import com.swp391.koibe.components.JwtTokenUtils;
import com.swp391.koibe.dtos.auctionkoi.AuctionKoiDTO;
import com.swp391.koibe.dtos.auctionkoi.UpdateAuctionKoiDTO;
import com.swp391.koibe.exceptions.GenerateDataException;
import com.swp391.koibe.exceptions.KoiRevokeException;
import com.swp391.koibe.exceptions.MalformBehaviourException;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.AuctionKoi;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.AuctionKoiResponse;
import com.swp391.koibe.responses.BidMethodQuantityResponse;
import com.swp391.koibe.responses.KoiInAuctionResponse;
import com.swp391.koibe.responses.base.BaseResponse;
import com.swp391.koibe.responses.pagination.KoiInAuctionPaginationResponse;
import com.swp391.koibe.services.auctionkoi.IAuctionKoiService;
import com.swp391.koibe.services.redis.koi.IKoiRedisService;
import com.swp391.koibe.services.user.IUserService;
import com.swp391.koibe.utils.DTOConverter;
import jakarta.validation.Valid;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("${api.prefix}/auctionkois")
@RequiredArgsConstructor
public class AuctionKoiController {

    private final IAuctionKoiService auctionKoiService;
    private final IUserService userService;
    private final IKoiRedisService koiRedisService;
    private final JwtTokenUtils jwtTokenUtils;

    @GetMapping("/count-by-bid-method")
    public ResponseEntity<BidMethodQuantityResponse> countAuctionKoiByBidMethod() {
        return ResponseEntity.ok(auctionKoiService.findQuantityByBidMethod());
    }

    @GetMapping("/auction/{id}")
    public ResponseEntity<List<AuctionKoiResponse>> getAuctionKoisByAuctionId(
        @PathVariable Long id) {
        try {
            return ResponseEntity.ok(auctionKoiService.getAuctionKoiByAuctionId(id));
        } catch (Exception e) {
            log.error("Error getting auctionkois by auction id: " + e.getMessage());
            throw new DataNotFoundException();
        }
    }

    @GetMapping("/{aid}/{id}")
    public ResponseEntity<?> getAuctionKoiByAuctionIdAndKoiId(@PathVariable Long aid,
                                                              @PathVariable Long id) {
        try {
            return ResponseEntity.ok(auctionKoiService.getAuctionKoiByAuctionIdAndKoiId(aid, id));
        } catch (Exception e) {
            log.error("Error getting auctionkoi by auction id and koi id: " + e.getMessage());
            throw new DataNotFoundException(
                "Error getting auctionkoi by auction id and koi id: " + e.getMessage());
        }
    }

    @GetMapping("") // /auctions/?page=1&limit=10
    public ResponseEntity<List<AuctionKoiResponse>> getAllAuctions(
        @RequestParam int page,
        @RequestParam int limit) {
        try {
            PageRequest pageRequest = PageRequest.of(page, limit);
            Page<AuctionKoiResponse> auctionKois = auctionKoiService.getAllAuctionKois(pageRequest);
            return ResponseEntity.ok(auctionKois.getContent());
        } catch (Exception e) {
            log.error("Error getting all auctionkois    : " + e.getMessage());
            throw new DataNotFoundException(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<AuctionKoiResponse> getAuctionKoiDetails(@PathVariable Long id) {
        try {
            AuctionKoiResponse auctionKoiResponse = auctionKoiService.getAuctionKoiDetailsById(id);
            return ResponseEntity.ok(auctionKoiResponse);
        } catch (DataNotFoundException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            log.error("Error getting auctionkoi by id: " + e.getMessage());
            throw new DataNotFoundException("Error getting auctionkoi by id: " + e.getMessage());
        }
    }

    // assign koi list to an auction
    @PostMapping("")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF', 'ROLE_BREEDER')")
    public ResponseEntity<AuctionKoiResponse> createAuctionKoi(
        @Valid @RequestBody AuctionKoiDTO auctionKoiDTO,
        BindingResult result
    ) throws Exception {
        User user = jwtTokenUtils.extractUserFromToken();

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        //check breeder account have enough money to register koi to auction
        if (user.getAccountBalance() < Math.floorDiv(auctionKoiDTO.basePrice(), 10)) {
            throw new MalformDataException("You dont have enough money to register Koi to Auction");
        }

        AuctionKoiResponse response = new AuctionKoiResponse();
        try {
            AuctionKoi newAuctionKoi = auctionKoiService.createAuctionKoi(auctionKoiDTO);
            response.setId(newAuctionKoi.getId());
            response.setBasePrice(newAuctionKoi.getBasePrice());
            response.setCeilPrice(newAuctionKoi.getCeilPrice());
            response.setBidMethod(String.valueOf(newAuctionKoi.getBidMethod()));
            response.setCurrentBid(newAuctionKoi.getCurrentBid());
            response.setCurrentBidderId(newAuctionKoi.getCurrentBidderId());
            response.setRevoked(newAuctionKoi.getRevoked());
            response.setSold(newAuctionKoi.isSold());
            response.setKoiId(newAuctionKoi.getKoi().getId());
            response.setAuctionId(newAuctionKoi.getAuction().getId());
            response.setBidStep(newAuctionKoi.getBidStep());
            //update breeder account balance
            userService.updateAccountBalance(user.getId(),
                                             -Math.floorDiv(auctionKoiDTO.basePrice(), 10));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("Error creating auctionkoi: " + e.getMessage());
            throw new GenerateDataException(e.getMessage());
        }
    }

    @PutMapping("/auctionkois/{auctionkoi_id}")
    public ResponseEntity<AuctionKoiResponse> updateAuctionKoi(
        @PathVariable Long auctionkoi_id,
        @Valid @RequestBody UpdateAuctionKoiDTO updateAuctionKoiDTO,
        BindingResult result) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }
        AuctionKoiResponse updatedAuctionKoi = auctionKoiService.updateAuctionKoi(auctionkoi_id,
                                                                                  updateAuctionKoiDTO);
        return ResponseEntity.ok(updatedAuctionKoi);
    }

    @PutMapping("/revoke/koi/{koi_id}/auction/{auction_id}")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER', 'ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<?> revokeKoiInAuction(
        @PathVariable Long koi_id,
        @PathVariable Long auction_id
    ) {

        BaseResponse<Object> response = new BaseResponse<>();
        try{
            auctionKoiService.revokeKoiInAuction(koi_id, auction_id);
            response.setMessage("Koi in Auction revoked successfully");
            response.setIsSuccess(true);
            response.setStatusCode(200);
            return ResponseEntity.ok(response);
        }catch (DataNotFoundException e){
            response.setMessage("Koi in Auction not found");
            response.setReason(e.getMessage());
            response.setIsSuccess(false);
            response.setStatusCode(404);
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }catch (MalformBehaviourException e){
            response.setMessage("Koi in Auction cannot be revoked");
            response.setReason(e.getMessage());
            response.setIsSuccess(false);
            response.setStatusCode(400);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER', 'ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<?> deleteAuctionKoi(@PathVariable Long id) {
        try {
            auctionKoiService.deleteAuctionKoi(id);
            return ResponseEntity.ok("AuctionKoi deleted successfully");
        } catch (Exception e) {
            log.error("Error deleting auctionkoi: " + e.getMessage());
            throw new DataNotFoundException("Error deleting auctionkoi: " + e.getMessage());
        }
    }

    @GetMapping("/get-kois-by-keyword")
    public ResponseEntity<KoiInAuctionPaginationResponse> getOrdersByKeyword(
        @RequestParam(defaultValue = "", required = false) String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit
    ) throws Exception {

        KoiInAuctionPaginationResponse response = new KoiInAuctionPaginationResponse();

        PageRequest pageRequest = PageRequest.of(
            page, limit,
            Sort.by("id").ascending()
        );

//        List<KoiInAuctionResponse> koiResponses = koiRedisService.findKoiInAuctionByKeyword(keyword, pageRequest);
//
//
//        if (koiResponses != null && !koiResponses.isEmpty()) {
//            response.setItem(koiResponses);
//            response.setTotalItem(koiResponses.size());
//            response.setTotalPage(koiResponses.get(0).getTotalPage());
//            return ResponseEntity.ok(response);
//        }

        Page<KoiInAuctionResponse> koiPage = auctionKoiService.getKoiByKeyword(keyword,
                                                                               pageRequest);
        response.setItem(koiPage.getContent());
        response.setTotalItem(koiPage.getTotalElements());
        response.setTotalPage(koiPage.getTotalPages());

//        int totalPage = koiPage.getTotalPages();
//        koiResponses = koiPage.getContent();
//        koiResponses.forEach(koi -> koi.setTotalPage(totalPage));
//
//        koiRedisService.saveAllKoiFindInAuctionByKeyword(koiResponses, keyword , pageRequest);

        return ResponseEntity.ok(response);
    }

}