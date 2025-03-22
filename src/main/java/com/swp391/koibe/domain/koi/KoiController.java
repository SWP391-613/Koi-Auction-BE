package com.swp391.koibe.domain.koi;

import com.swp391.koibe.components.JwtTokenUtils;
import com.swp391.koibe.domain.asset.IFileStoreService;
import com.swp391.koibe.domain.koi.KoiPort.KoiImageDTO;
import com.swp391.koibe.domain.mail.KoiDTO;
import com.swp391.koibe.domain.mail.UpdateKoiDTO;
import com.swp391.koibe.domain.mail.UpdateKoiStatusDTO;
import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.domain.user.User;
import com.swp391.koibe.api.ApiResponse;
import com.swp391.koibe.api.PageResponse;
import com.swp391.koibe.metadata.MediaMeta;
import com.swp391.koibe.redis.koi.IKoiRedisService;
import com.swp391.koibe.domain.user.IUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RequestMapping("${api.prefix}/kois")
@RestController
@RequiredArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE, makeFinal = true)
@Tag(name = "Koi", description = "APIs for managing koi")
public class KoiController {

    IKoiService<KoiPort.KoiResponse> koiService;
    IUserService userService;
    IKoiRedisService koiRedisService;
    IFileStoreService fileStoreService;

    @Operation(summary = "Get all kois", description = "Get all kois with pagination")
    @GetMapping("") //kois/?page=0&limit=10
    public ResponseEntity<PageResponse<KoiPort.KoiResponse>> getAllKois(
        @RequestParam(required = false, defaultValue = "0") int page,
        @RequestParam(required = false, defaultValue = "10") int limit,
        @RequestParam(defaultValue = "") String keyword
    ) {
        return ResponseEntity.ok(koiService.findAllKoiByKeyword(keyword, PageRequest.of(page,
                                                                                        limit)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<KoiPort.KoiResponse>> getKoi(@PathVariable long id) {
        return ResponseEntity.ok(ApiResponse.<KoiPort.KoiResponse>builder()
                                     .data(koiService.getKoiById(id).blockingGet())
                                     .statusCode(200)
                                     .isSuccess(true)
                                     .message("Koi fetched successfully")
                                     .build());
    }

    @GetMapping("/status")
    public ResponseEntity<PageResponse<KoiPort.KoiResponse>> getKoiListByStatus(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "20") int limit,
        @RequestParam String status
    ) {
        return ResponseEntity.ok(
            koiService.getKoiByStatus(PageRequest.of(page, limit),
                                      EKoiStatus.valueOf(status.toUpperCase())));
    }

    @GetMapping("/get-kois-owner-by-keyword")
    public ResponseEntity<PageResponse<KoiPort.KoiResponse>> getKoisByKeyword(
        @RequestParam(defaultValue = "", required = false) String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit
    ) throws Exception {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
            .getAuthentication().getPrincipal();
        User user = userService.findByUsername(userDetails.getUsername());

        return ResponseEntity.ok(
            koiService.findKoiByKeyword(
                keyword,
                user.getId(),
                PageRequest.of(page, limit)));
    }

    @GetMapping("/get-kois-owner-by-keyword-not-auth")
    public ResponseEntity<PageResponse<KoiPort.KoiResponse>> getKoisByKeywordNotAuth(
        @RequestParam(defaultValue = "") String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit,
        @RequestParam("owner_id") Long ownerId
    ) throws Exception {

        KoiPaginationResponse response = new KoiPaginationResponse();

        PageRequest pageRequest = PageRequest.of(
            page, limit,
            //Sort.by("createdAt").descending()
            Sort.by("id").ascending()
        );

//        List<KoiPort.KoiResponse> KoiPort.KoiResponses = koiRedisService.findKoiByKeyword(keyword, ownerId, pageRequest);
//
//        if (KoiPort.KoiResponses != null && !KoiPort.KoiResponses.isEmpty()) {
//            response.setItem(KoiPort.KoiResponses);
//            response.setTotalItem(KoiPort.KoiResponses.size());
//            response.setTotalPage(KoiPort.KoiResponses.get(0).getTotalPage());
//            return ResponseEntity.ok(response);
//        }

        // If not found in Redis, fetch from the database.
        PageResponse<KoiPort.KoiResponse> koiPage = koiService.findKoiByKeyword(
            keyword,
            ownerId,
            pageRequest);

//        int totalPage = koiPage.getTotalPages();
//        KoiPort.KoiResponses = koiPage.getContent();
//        for(KoiPort.KoiResponse koi: KoiPort.KoiResponses){@
//            koi.setTotalPage(totalPage);
//        }
//
//        koiRedisService.saveAllKois(
//            KoiPort.KoiResponses,
//            keyword,
//            ownerId,
//            pageRequest);

        return ResponseEntity.ok(koiPage);
    }

//    @GetMapping("/get-all-kois-by-keyword")
//    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
//    public ResponseEntity<PageResponse<KoiPort.KoiResponse>> getAllKoisByKeyword(
//        @RequestParam(defaultValue = "") String keyword,
//        @RequestParam(defaultValue = "0") int page,
//        @RequestParam(defaultValue = "10") int limit
//    ) throws Exception {
//        return ResponseEntity.ok(koiService.findAllKoiByKeyword(keyword,  PageRequest.of(page, limit)));
//    }

    @GetMapping("/get-unverified-kois-by-keyword")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF','ROLE_BREEDER')")
    public ResponseEntity<PageResponse<KoiPort.KoiResponse>> getUnverifiedKoisByKeyword(
        @RequestParam(defaultValue = "") String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit
    ) {
        return ResponseEntity.ok(
            koiService.findUnverifiedKoiByKeyword(
                keyword,
                PageRequest.of(page,
                               limit,
                               Sort.by(Sort.Order.desc("createdAt")))));
    }


    @PostMapping(value = "")
    @PreAuthorize("hasRole('ROLE_BREEDER')")
    public ResponseEntity<ApiResponse<KoiPort.KoiResponse>> createNewKoi(
        @Valid @RequestBody KoiDTO koiDTO,
        //@ModelAttribute("files") List<MultipartFile> files,
        //@RequestPart("file") MultipartFile file,
        BindingResult result
    ) throws Exception {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
            .getAuthentication().getPrincipal();
        User user = userService.findByUsername(userDetails.getUsername());

        //need to save the product first to get the product id, get the id and add the image
        return ResponseEntity.status(HttpStatus.CREATED).body(
            ApiResponse.<KoiPort.KoiResponse>builder()
                .message("Koi created successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.CREATED.value())
                .data(koiService.createKoi(koiDTO, user.getId()).blockingGet())
                .build()
        );
    }

    @PatchMapping("/status/{id}")
    @PreAuthorize("hasAnyRole('ROLE_STAFF')")
    public ResponseEntity<String> updateKoiStatus(
        @PathVariable("id") Long koiId,
        @Valid @RequestBody UpdateKoiStatusDTO updateKoiStatusDTO,
        BindingResult result
    ) {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        koiService.updateKoiStatus(koiId, updateKoiStatusDTO);
        return ResponseEntity.ok().body("Koi status updated successfully");
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER', 'ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<KoiPort.KoiResponse> updateProduct(
        @PathVariable("id") Long koiId,
        @Valid @RequestBody UpdateKoiDTO updateKoiDTO,
        BindingResult result
    ) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }
        return ResponseEntity.ok(koiService.updateKoi(koiId, updateKoiDTO));
    }

    @Operation(summary = "Soft Delete koi by id", description = "Soft delete koi by id")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER', 'ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<ApiResponse<KoiPort.KoiResponse>> delete(@PathVariable("id") Long koiId)
        throws Exception {
        koiService.deleteKoi(koiId);

        return ResponseEntity.ok(
            ApiResponse.<KoiPort.KoiResponse>builder()
                .message("Koi deleted successfully")
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .build()
        );
    }

    @PostMapping(value = "uploads/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasRole('ROLE_BREEDER')")
    public ResponseEntity<ApiResponse<List<KoiImage>>> uploadImages(
        @PathVariable("id") Long koiId,
        @ModelAttribute("files") List<MultipartFile> files
    ) throws Exception {

        KoiPort.KoiResponse existingKoi = koiService.getKoiById(koiId).blockingGet();
        List<KoiImage> koiImages = new ArrayList<>();
        for (MultipartFile file : fileStoreService.validateListProductImage(files)) {
            //Store file
            String fileName = fileStoreService.storeFile(file);

            MediaMeta mediaMeta = MediaMeta.builder()
                .fileName(fileName)
                .fileType(file.getContentType())
                .fileSize(file.getSize())
                .imageUrl(fileName)
                .videoUrl(null)
                .build();

            KoiImage koiImage = koiService.createKoiImage(
                existingKoi.id(),
                mediaMeta,
                new KoiImageDTO(
                    existingKoi.id(),
                    mediaMeta.getFileName(),
                    mediaMeta.getVideoUrl()
                ));
            //save to product_images later
            koiImages.add(koiImage);
        }
        return ResponseEntity.ok().body(
            ApiResponse.<List<KoiImage>>builder()
                .message("Upload image success")
                .statusCode(HttpStatus.OK.value())
                .isSuccess(true)
                .data(koiImages).build()
        );

    }

}
