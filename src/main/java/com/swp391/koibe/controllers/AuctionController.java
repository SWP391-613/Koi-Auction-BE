package com.swp391.koibe.controllers;

import com.swp391.koibe.dtos.AuctionDTO;
import com.swp391.koibe.dtos.UpdateAuctionDTO;
import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.responses.AuctionResponse;
import com.swp391.koibe.responses.AuctionStatusCountResponse;
import com.swp391.koibe.responses.base.ApiResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.services.auction.IAuctionMailService;
import com.swp391.koibe.services.auction.IAuctionService;
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
@RequestMapping("${api.prefix}/auctions")
@RestController
@RequiredArgsConstructor
public class AuctionController {

    private final IAuctionService auctionService;
    private final IAuctionMailService auctionMailService;

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

    @GetMapping("/notify/upcoming")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<?> notifyAllUserUpcomingAuction() {
        try {
            auctionMailService.notifyUsersAboutUpcomingAuctions();
            return ResponseEntity.ok("Success");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    //pagination for auctions
    @GetMapping("") // /auctions/?page=1&limit=10
    public ResponseEntity<PageResponse<AuctionResponse>> getAllAuctions(
        @RequestParam int page,
        @RequestParam int limit) {
        return ResponseEntity.ok(auctionService.getAllAuctions(PageRequest.of(page, limit)));
    }

    @GetMapping("/koi_register")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER')")
    public ResponseEntity<List<AuctionResponse>> getAuctionsByStatus(
        @RequestParam int page,
        @RequestParam int limit,
        @RequestParam String status) {
        try {
            PageRequest pageRequest = PageRequest.of(page, limit);
            EAuctionStatus auctionStatus = EAuctionStatus.valueOf(status.toUpperCase());
            Page<AuctionResponse> auctions = auctionService.getAuctionByStatus(auctionStatus,
                                                                               pageRequest);
            return ResponseEntity.ok(auctions.getContent());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(null); // Handle invalid status value
        } catch (Exception e) {
            log.error("Error getting all auctions: " + e.getMessage());
            throw new DataNotFoundException();
        }
    }

    @GetMapping("/staff")
    public ResponseEntity<ApiResponse<List<AuctionResponse>>> getAuctionHandledByStaff(
        @RequestParam long id
    ) {
        if (id <= 0) {
            throw new MalformDataException("Invalid staff id, staff id must greater than 0");
        }
        return ResponseEntity.ok(
            ApiResponse.<List<AuctionResponse>>builder()
                .message("Get Auction handle by staff successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .data(auctionService.getAuctionByAuctioneerId(id))
                .build());
    }


    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<AuctionResponse>> getAuctionById(@PathVariable long id) {
        AuctionResponse auction = auctionService.getById(id);

        return ResponseEntity.ok(
            ApiResponse.<AuctionResponse>builder()
                .message("Auction found successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .data(auction)
                .build()
        );
    }

    @GetMapping("/get-auctions-by-keyword")
    public ResponseEntity<PageResponse<AuctionResponse>> getAuctionsByKeyword(
        @RequestParam(defaultValue = "", required = false) String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit) {
        // Tạo Pageable từ thông tin trang và giới hạn

        return ResponseEntity.ok(
            auctionService.getAuctionByKeyword(
                keyword,
                PageRequest.of(page, limit, Sort.by("id").descending())));

    }

    @GetMapping("/get-auctions-upcoming")
    public ResponseEntity<PageResponse<AuctionResponse>> getAuctionsUpcomingByKeyword(
        @RequestParam(defaultValue = "", required = false) String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit) {
        return ResponseEntity.ok(
            auctionService.getAuctionUpcomingByKeyword(
                keyword,
                EAuctionStatus.UPCOMING,
                PageRequest.of(page, limit, Sort.by("id").descending())));
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    public ResponseEntity<ApiResponse<AuctionResponse>> createAuction(
        @Valid @RequestBody AuctionDTO auctionDTO,
        BindingResult result
    ) {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        return ResponseEntity.status(201).body(
            ApiResponse.<AuctionResponse>builder()
                .message("Auction created successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.CREATED.value())
                .data(auctionService.createAscendingAuction(auctionDTO))
                .build()
        );
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<ApiResponse<AuctionResponse>> updateAuction(
        @PathVariable long id,
        @Valid @RequestBody UpdateAuctionDTO updateAuctionDTO,
        BindingResult result) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        return ResponseEntity.ok(
            ApiResponse.<AuctionResponse>builder()
                .message("Auction updated successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .data(auctionService.update(id, updateAuctionDTO))
                .build());
    }

    @PutMapping("/end/{id}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<ApiResponse<String>> endAuction(
        @PathVariable long id) {
        auctionService.end(id);

        return ResponseEntity.ok().body(
            ApiResponse.<String>builder()
                .message("Auction ended successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .data(null)
                .build()
        );
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public ResponseEntity<ApiResponse<AuctionResponse>> deleteAuction(@PathVariable long id) {
        auctionService.delete(id);
        return ResponseEntity.ok(
            ApiResponse.<AuctionResponse>builder()
                .message("Auction deleted successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .data(null)
                .build()
        );
    }

}
