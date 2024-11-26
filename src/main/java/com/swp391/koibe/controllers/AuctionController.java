package com.swp391.koibe.controllers;

import com.github.javafaker.Faker;
import com.swp391.koibe.dtos.AuctionDTO;
import com.swp391.koibe.dtos.UpdateAuctionDTO;
import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.exceptions.GenerateDataException;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.Auction;
import com.swp391.koibe.responses.AuctionResponse;
import com.swp391.koibe.responses.AuctionStatusCountResponse;
import com.swp391.koibe.responses.pagination.AuctionPaginationResponse;
import com.swp391.koibe.services.auction.IAuctionMailService;
import com.swp391.koibe.services.auction.IAuctionService;
import com.swp391.koibe.utils.DTOConverter;
import jakarta.validation.Valid;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
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
    public ResponseEntity<AuctionStatusCountResponse> countAuctionByStatus() {
        return ResponseEntity.ok(auctionService.countAuctionByStatus());
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
    public ResponseEntity<List<AuctionResponse>> getAllAuctions(
        @RequestParam int page,
        @RequestParam int limit) {
        try {
            PageRequest pageRequest = PageRequest.of(page, limit);
            Page<AuctionResponse> auctions = auctionService.getAllAuctions(pageRequest);
            return ResponseEntity.ok(auctions.getContent());
        } catch (Exception e) {
            log.error("Error getting all auctions: " + e.getMessage());
            throw new DataNotFoundException();
        }
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
    public ResponseEntity<?> getAuctionHandledByStaff(
        @RequestParam long id
    ) {
        if (id <= 0) {
            throw new MalformDataException("Invalid staff id, staff id must greater than 0");
        }
        try {
            //convert to List<AuctionResponse>
            List<AuctionResponse> auctionDTOs = auctionService
                .getAuctionByAuctioneerId(id)
                .stream()
                .map(DTOConverter::convertToAuctionDTO)
                .collect(Collectors.toList());

            return ResponseEntity.ok(auctionDTOs);
        } catch (Exception e) {
            log.error("Error getting auction handled by staff: " + e.getMessage());
            if (e instanceof DataNotFoundException) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }


    @GetMapping("/{id}")
    public ResponseEntity<AuctionResponse> getAuctionById(@PathVariable long id) {
        try {
            AuctionResponse auction = auctionService.getById(id);
            return ResponseEntity.ok(auction);
        } catch (Exception e) {
            log.error("Error getting auction by id: " + e.getMessage());
            throw new DataNotFoundException();
        }
    }

    @GetMapping("/get-auctions-by-keyword")
    public ResponseEntity<AuctionPaginationResponse> getAuctionsByKeyword(
        @RequestParam(defaultValue = "", required = false) String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit) {
        // Tạo Pageable từ thông tin trang và giới hạn
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("id").descending());
        Page<AuctionResponse> auctionPage = auctionService
            .getAuctionByKeyword(keyword, pageRequest).map(DTOConverter::convertToAuctionDTO);
        AuctionPaginationResponse response = new AuctionPaginationResponse();
        response.setItem(auctionPage.getContent());
        response.setTotalItem(auctionPage.getTotalElements());
        response.setTotalPage(auctionPage.getTotalPages());

        return ResponseEntity.ok(response);
    }

    @GetMapping("/get-auctions-upcoming")
    public ResponseEntity<AuctionPaginationResponse> getAuctionsUpcomingByKeyword(
        @RequestParam(defaultValue = "", required = false) String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit) {
        // Tạo Pageable từ thông tin trang và giới hạn
        PageRequest pageRequest = PageRequest.of(page, limit);
        Page<AuctionResponse> auctionPage = auctionService
            .getAuctionUpcomingByKeyword(keyword, EAuctionStatus.UPCOMING, pageRequest).map(DTOConverter::convertToAuctionDTO);
        AuctionPaginationResponse response = new AuctionPaginationResponse();
        response.setItem(auctionPage.getContent());
        response.setTotalItem(auctionPage.getTotalElements());
        response.setTotalPage(auctionPage.getTotalPages());

        return ResponseEntity.ok(response);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    public ResponseEntity<AuctionResponse> createAuction(
        @Valid @RequestBody AuctionDTO auctionDTO,
        BindingResult result
    ) {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        AuctionResponse response = new AuctionResponse();
        try {
            Auction newAuction = auctionService.createAscendingAuction(auctionDTO);
            response.setTitle(newAuction.getTitle());
            response.setStartTime(String.valueOf(newAuction.getStartTime()));
            response.setEndTime(String.valueOf(newAuction.getEndTime()));
            response.setStatus(newAuction.getStatus().getStatus());
            response.setAuctioneerId(newAuction.getAuctioneer().getId());
            return ResponseEntity.status(201).body(response);
        } catch (Exception e) {
            if (e instanceof MalformDataException) {
                throw e;
            }
            log.error("Error creating auction: " + e.getMessage());
            response.setMessage(e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<AuctionResponse> updateAuction(
        @PathVariable long id,
        @Valid @RequestBody UpdateAuctionDTO updateAuctionDTO,
        BindingResult result) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        AuctionResponse response = new AuctionResponse();

        try {
            Auction updatedAuction = auctionService.update(id, updateAuctionDTO);
            response.setId(updatedAuction.getId());
            response.setTitle(updatedAuction.getTitle());
            response.setStartTime(String.valueOf(updatedAuction.getStartTime()));
            response.setEndTime(String.valueOf(updatedAuction.getEndTime()));
            response.setStatus(updatedAuction.getStatus().getStatus());
            response.setAuctioneerId(updatedAuction.getAuctioneer().getId());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("Error updating auction: " + e.getMessage());
            response.setMessage(e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PutMapping("/end/{id}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<String> endAuction(
        @PathVariable long id) {
        auctionService.end(id);
        return ResponseEntity.ok().body("End auction successfully");
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public ResponseEntity<AuctionResponse> deleteAuction(@PathVariable long id) {
        AuctionResponse response = new AuctionResponse();
        try {
            auctionService.delete(id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            log.error("Error deleting auction: " + e.getMessage());
            response.setMessage("Error deleting auction: " + e.getMessage());
            response.setReason(e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

}
