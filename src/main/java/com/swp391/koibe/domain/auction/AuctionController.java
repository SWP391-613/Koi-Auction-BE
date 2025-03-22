package com.swp391.koibe.domain.auction;

import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.api.ApiResponse;
import com.swp391.koibe.api.PageResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import java.util.List;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequestMapping("${api.prefix}/auctions")
@RestController
@RequiredArgsConstructor
@Tag(name = "Auctions", description = "APIs for managing auctions")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuctionController {

    IAuctionContract auctionContract;
    IAuctionMailService auctionMailService;

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

    @Operation(summary = "Get all auctions", description = "Get all auctions with pagination")
    @GetMapping("")
    public ResponseEntity<PageResponse<AuctionResponse>> getAllAuctions(
        @RequestParam(required = false, defaultValue = "0") int page,
        @RequestParam(required = false, defaultValue = "10") int limit,
        @RequestParam(required = false, defaultValue = "") String keyword,
        @RequestParam(required = false) EAuctionStatus status
    ) {

        return ResponseEntity.ok(
            auctionContract.getAuctionByKeyword(
                keyword,
                status,
                PageRequest.of(page, limit, Sort.by("id").descending())));
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
                .data(auctionContract.getAuctionByAuctioneerId(id))
                .build());
    }


    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<AuctionResponse>> getDetailById(@PathVariable long id) {
        return ResponseEntity.ok(
            ApiResponse.<AuctionResponse>builder()
                .message("Auction found successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .data(auctionContract.getAuctionById(id))
                .build()
        );
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    public ResponseEntity<ApiResponse<AuctionResponse>> createAuction(
        @Valid @RequestBody AuctionPort.AuctionDTO auctionDTO,
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
                .data(auctionContract.createAscendingAuction(auctionDTO))
                .build()
        );
    }

    @PatchMapping("/{id}")
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
                .data(auctionContract.update(id, updateAuctionDTO))
                .build());
    }

    @PatchMapping("/end/{id}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<ApiResponse<String>> endAuction(
        @PathVariable long id) {
        auctionContract.end(id);

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
        auctionContract.delete(id);
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
