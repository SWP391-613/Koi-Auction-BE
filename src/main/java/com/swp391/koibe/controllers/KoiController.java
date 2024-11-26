package com.swp391.koibe.controllers;

import com.swp391.koibe.components.JwtTokenUtils;
import com.swp391.koibe.dtos.KoiImageDTO;
import com.swp391.koibe.dtos.koi.KoiDTO;
import com.swp391.koibe.dtos.koi.UpdateKoiDTO;
import com.swp391.koibe.dtos.koi.UpdateKoiStatusDTO;
import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.exceptions.MalformBehaviourException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.Koi;
import com.swp391.koibe.models.KoiImage;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.KoiGenderResponse;
import com.swp391.koibe.responses.KoiResponse;
import com.swp391.koibe.responses.KoiStatusResponse;
import com.swp391.koibe.responses.base.ApiResponse;
import com.swp391.koibe.responses.base.BaseResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.responses.pagination.KoiPaginationResponse;
import com.swp391.koibe.services.koi.IKoiService;
import com.swp391.koibe.services.redis.koi.IKoiRedisService;
import com.swp391.koibe.services.user.IUserService;
import com.swp391.koibe.utils.DTOConverter;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RequestMapping("${api.prefix}/kois")
@RestController
@RequiredArgsConstructor
public class KoiController {

    private final IKoiService<KoiResponse> koiService;
    private final IUserService userService;
    private final IKoiRedisService koiRedisService;
    private final JwtTokenUtils jwtTokenUtils;

    @GetMapping("/count-by-gender")
    public ResponseEntity<ApiResponse<KoiGenderResponse>> getQuantityKoiGender() {
        return ResponseEntity.ok(ApiResponse.<KoiGenderResponse>builder()
                                     .message("Koi count fetched successfully")
                                     .isSuccess(true)
                                     .statusCode(HttpStatus.OK.value())
                                     .data(koiService.findQuantityKoiByGender())
                                     .build());
    }

    @GetMapping("/count-by-status")
    public ResponseEntity<ApiResponse<KoiStatusResponse>> getQuantityKoiStatus() {
        return ResponseEntity.ok(ApiResponse.<KoiStatusResponse>builder()
                                     .message("Koi count fetched successfully")
                                     .isSuccess(true)
                                     .statusCode(HttpStatus.OK.value())
                                     .data(koiService.findQuantityKoiByStatus())
                                     .build());

    }

    @GetMapping("") //kois/?page=0&limit=10
    public ResponseEntity<PageResponse<KoiResponse>> getAllKois(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "0") int limit
    ) {
        return ResponseEntity.ok(koiService.getAllKois(PageRequest.of(page, limit)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<KoiResponse>> getKoi(@PathVariable long id) {
        return ResponseEntity.ok(ApiResponse.<KoiResponse>builder()
                                     .data(koiService.getKoiById(id).blockingGet())
                                     .statusCode(200)
                                     .isSuccess(true)
                                     .message("Koi fetched successfully")
                                     .build());
    }

    @GetMapping("/status")
    public ResponseEntity<PageResponse<KoiResponse>> getKoiListByStatus(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "20") int limit,
        @RequestParam String status
    ) {
        return ResponseEntity.ok(
            koiService.getKoiByStatus(PageRequest.of(page, limit),
                                      EKoiStatus.valueOf(status.toUpperCase())));
    }

    @GetMapping("/owner/{owner_id}/status")
    public ResponseEntity<PageResponse<KoiResponse>> getBreederKoiListByStatus(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "20") int limit,
        @PathVariable("owner_id") Long ownerId,
        @RequestParam String status
    ) {
        return ResponseEntity.ok(
            koiService.getBreederKoiByStatus(PageRequest.of(page, limit),
                                             ownerId,
                                             EKoiStatus.valueOf(status.toUpperCase())));
    }

    @GetMapping("/get-kois-owner-by-keyword")
    public ResponseEntity<PageResponse<KoiResponse>> getKoisByKeyword(
        @RequestParam(defaultValue = "", required = false) String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit
    ) throws Exception {
        return ResponseEntity.ok(
            koiService.findKoiByKeyword(
                keyword,
                jwtTokenUtils.extractUserFromToken().getId(),
                PageRequest.of(page, limit)));
    }

    @GetMapping("/get-kois-owner-by-keyword-not-auth")
    public ResponseEntity<PageResponse<KoiResponse>> getKoisByKeywordNotAuth(
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

//        List<KoiResponse> koiResponses = koiRedisService.findKoiByKeyword(keyword, ownerId, pageRequest);
//
//        if (koiResponses != null && !koiResponses.isEmpty()) {
//            response.setItem(koiResponses);
//            response.setTotalItem(koiResponses.size());
//            response.setTotalPage(koiResponses.get(0).getTotalPage());
//            return ResponseEntity.ok(response);
//        }

        // If not found in Redis, fetch from the database.
        PageResponse<KoiResponse> koiPage = koiService.findKoiByKeyword(
            keyword,
            ownerId,
            pageRequest);

//        int totalPage = koiPage.getTotalPages();
//        koiResponses = koiPage.getContent();
//        for(KoiResponse koi: koiResponses){@
//            koi.setTotalPage(totalPage);
//        }
//
//        koiRedisService.saveAllKois(
//            koiResponses,
//            keyword,
//            ownerId,
//            pageRequest);

        return ResponseEntity.ok(koiPage);
    }

    @GetMapping("/get-all-kois-by-keyword")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<PageResponse<KoiResponse>> getAllKoisByKeyword(
        @RequestParam(defaultValue = "") String keyword,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit
    ) throws Exception {
        return ResponseEntity.ok(koiService.findAllKoiByKeyword(keyword,  PageRequest.of(page, limit)));
    }

    @GetMapping("/get-unverified-kois-by-keyword")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF','ROLE_BREEDER')")
    public ResponseEntity<PageResponse<KoiResponse>> getUnverifiedKoisByKeyword(
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
    public ResponseEntity<KoiResponse> createNewKoi(
        @Valid @RequestBody KoiDTO koiDTO,
        //@ModelAttribute("files") List<MultipartFile> files,
        //@RequestPart("file") MultipartFile file,
        BindingResult result
    ) {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        KoiResponse response = new KoiResponse();

        try {
            User user = jwtTokenUtils.extractUserFromToken();

            //need to save the product first to get the product id, get the id and add the image
            Koi newKoi = koiService.createKoi(koiDTO, user.getId()).blockingGet();
            return ResponseEntity.ok(DTOConverter.convertToKoiDTO(newKoi));
        } catch (Exception e) {
            response.setMessage("Error creating new koi");
            response.setReason(e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PutMapping("/status/{id}")
    @PreAuthorize("hasAnyRole('ROLE_STAFF')")
    public ResponseEntity<String> updateKoiStatus(
        @PathVariable("id") Long koiId,
        @Valid @RequestBody UpdateKoiStatusDTO updateKoiStatusDTO,
        BindingResult result
    ) {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }
        try {
            koiService.updateKoiStatus(koiId, updateKoiStatusDTO);
            return ResponseEntity.ok().body("Koi status updated successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error updating koi status: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER', 'ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<KoiResponse> updateProduct(
        @PathVariable("id") Long koiId,
        @Valid @RequestBody UpdateKoiDTO updateKoiDTO,
        BindingResult result
    ) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }
        return ResponseEntity.ok(koiService.updateKoi(koiId, updateKoiDTO));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_BREEDER', 'ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<?> deleteProduct(@PathVariable("id") Long koiId) throws Exception {
        BaseResponse<Koi> response = new BaseResponse<>();
        try{
            koiService.deleteKoi(koiId);
            response.setMessage("Delete koi successfully");
            response.setReason("Koi deleted successfully");
            response.setIsSuccess(true);
            response.setStatusCode(HttpStatus.OK.value());
            return ResponseEntity.ok(response);
        }catch(DataNotFoundException e){
            response.setMessage("Delete koi failed");
            response.setReason(e.getMessage());
            response.setIsSuccess(false);
            response.setStatusCode(HttpStatus.NOT_FOUND.value());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }catch (MalformBehaviourException e){
            response.setMessage("Delete koi failed");
            response.setReason(e.getMessage());
            response.setIsSuccess(false);
            response.setStatusCode(HttpStatus.BAD_REQUEST.value());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    @PostMapping(value = "uploads/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasRole('ROLE_BREEDER')")
    public ResponseEntity<?> uploadImages(
        @PathVariable("id") Long koiId,
        @ModelAttribute("files") List<MultipartFile> files
    ) {
        try {
            KoiResponse existingKoi = koiService.getKoiById(koiId).blockingGet();
            files = files == null ? new ArrayList<>() : files;
            if (files.size() > KoiImage.MAXIMUM_IMAGES_PER_PRODUCT) {
                return ResponseEntity.badRequest().body(
                    "Maximum images per product: "
                        + KoiImage.MAXIMUM_IMAGES_PER_PRODUCT
                        + " found: " + files.size());
            }
            List<KoiImage> koiImages = new ArrayList<>();
            for (MultipartFile file : files) {
                if (file.getSize() == 0) {
                    continue;
                }

                if (file.getSize() > 10 * 1024 * 1024) {
                    //throw new ResponseStatusException(HttpStatus.PAYLOAD_TOO_LARGE, "File size must be less than 10MB");
                    return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
                        .body("File size must be less than 10MB");
                }
                String contentType = file.getContentType(); //check if the file is image
                if (contentType == null || !contentType.startsWith("image/")) {
                    return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                        .body("File must be an image");
                }
                //Store file
                String fileName = storeFile(file);
                KoiImage koiImage = koiService.createKoiImage(
                    existingKoi.getId(),
                    KoiImageDTO.builder()
                        .imageUrl(fileName)
                        .build());
                //save to product_images later
                koiImages.add(koiImage);
            }
            return ResponseEntity.ok().body(koiImages);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    private boolean isImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        return contentType != null && contentType.startsWith("image/");
    }

    private String storeFile(MultipartFile file) throws IOException {
        if (!isImageFile(file) || file.getOriginalFilename() == null) {
            throw new IOException("Invalid image format");
        }
        String filename = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
        String uniqueFileName = UUID.randomUUID() + "_" + filename;
        Path uploadDir = Paths.get("uploads");
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        //File.separator: depends on the OS, for windows it is '\', for linux it is '/'
        Path destination = Paths.get(uploadDir + File.separator + uniqueFileName);
        //copy the file to the destination
        Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
        return uniqueFileName;
    }

}
