package com.swp391.koibe.controllers;

import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.BreederResponse;
import com.swp391.koibe.responses.KoiResponse;
import com.swp391.koibe.responses.UserResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.responses.pagination.BreederPaginationResponse;
import com.swp391.koibe.responses.pagination.KoiPaginationResponse;
import com.swp391.koibe.services.user.breeder.IBreederService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("${api.prefix}/breeders")
public class BreederController {

    private final IBreederService breederService;

    @GetMapping("")
    public ResponseEntity<PageResponse<BreederResponse>> getAllBreeders(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "0") int limit
    ) {
        return ResponseEntity.ok(breederService.getAllBreeders(PageRequest.of(page, limit)));
    }

    @GetMapping("/all")
    public ResponseEntity<List<UserResponse>> getAllBreeders() {
        try {
            List<UserResponse> breeders = breederService.getAllBreeders();
            return ResponseEntity.ok(breeders);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getBreederById(@PathVariable long id) {
        try {
            User breeder = breederService.findById(id);
            return ResponseEntity.ok(breeder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/kois")
    public ResponseEntity<KoiPaginationResponse> getKoisByBreederId(
        @RequestParam("breeder_id") long breeder_id,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "0") int limit) {

        KoiPaginationResponse response = new KoiPaginationResponse();

        try {
            PageRequest pageRequest = PageRequest.of(page, limit);
            Page<KoiResponse> koiList = breederService.getKoisByBreederID(breeder_id, pageRequest);
            response.setItem(koiList.getContent());
            response.setTotalPage(koiList.getTotalPages());
            response.setTotalItem(koiList.getTotalElements());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/kois/status")
    public ResponseEntity<KoiPaginationResponse> getKoisByBreederIdAndStatus(
        @RequestParam("breeder_id") long breeder_id,
        @RequestParam("status") String koi_status,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "0") int limit) {

        KoiPaginationResponse response = new KoiPaginationResponse();

        PageRequest pageRequest = PageRequest.of(page, limit);
        Page<KoiResponse> koiList = breederService.getKoisByBreederIdAndStatus(
            breeder_id,
            EKoiStatus.valueOf(koi_status),
            pageRequest);

        response.setItem(koiList.getContent());
        response.setTotalPage(koiList.getTotalPages());
        response.setTotalItem(koiList.getTotalElements());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/kois/not-in-auction")
    @PreAuthorize("hasRole('BREEDER')")
    public ResponseEntity<KoiPaginationResponse> getKoisByBreederIdNotInAnyAuction(
        @RequestParam("breeder_id") long breeder_id,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "0") int limit) {

        KoiPaginationResponse response = new KoiPaginationResponse();

        PageRequest pageRequest = PageRequest.of(page, limit);
        Page<KoiResponse> koiList = breederService.getKoisByBreederIdNotInAnyAuction(
            breeder_id,
            pageRequest);

        response.setItem(koiList.getContent());
        response.setTotalPage(koiList.getTotalPages());
        response.setTotalItem(koiList.getTotalElements());
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{breeder_id}/koi/{id}")
    public ResponseEntity<?> deleteKoi(
        @PathVariable("id") long id,
        @PathVariable("breeder_id") long breederId
    ) {
        try {
            breederService.deleteKoi(id, breederId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

}
