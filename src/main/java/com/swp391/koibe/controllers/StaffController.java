package com.swp391.koibe.controllers;

import com.swp391.koibe.dtos.StaffRegisterDTO;
import com.swp391.koibe.dtos.UserDTO;
import com.swp391.koibe.exceptions.InvalidApiPathVariableException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.exceptions.PermissionDeniedException;
import com.swp391.koibe.responses.StaffResponse;
import com.swp391.koibe.responses.base.ApiResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.services.user.staff.IStaffService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
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

@RestController
@RequiredArgsConstructor
@RequestMapping("${api.prefix}/staffs")
public class StaffController {

    private final IStaffService staffService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<PageResponse<StaffResponse>> getAllStaffs(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int limit
    ) {
        return ResponseEntity.ok(staffService.getAllStaffs(PageRequest.of(page, limit)));
    }

    @GetMapping("/active")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<PageResponse<StaffResponse>> getAllStaffsWithActive(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "0") int limit
    ) {
        return ResponseEntity.ok(staffService.findAllStaffWithActive(PageRequest.of(page, limit)));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    public ResponseEntity<ApiResponse<StaffResponse>> getStaffById(@PathVariable long id) {
        return ResponseEntity.ok(ApiResponse.<StaffResponse>builder()
                                     .message("Get staff by id successfully")
                                     .statusCode(200)
                                     .isSuccess(true)
                                     .data(staffService.findById(id))
                                     .build());
    }

    @PostMapping("")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public ResponseEntity<ApiResponse<StaffResponse>> createStaff(
        @Valid @RequestBody StaffRegisterDTO staff,
        BindingResult result
    ) throws PermissionDeniedException {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }
        return ResponseEntity.ok(ApiResponse.<StaffResponse>builder()
                                    .message("Create staff successfully")
                                    .statusCode(200)
                                    .isSuccess(true)
                                    .data(staffService.createNewStaff(staff))
                                    .build());
    }

    //update an existing member to staff
    @PutMapping("/new/{id}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<ApiResponse<StaffResponse>> updateMemberToStaff(
        @PathVariable long id
    ) {
        if (id <= 0) {
            throw new InvalidApiPathVariableException("Staff id must be greater than 0");
        }

        return ResponseEntity.ok(
            ApiResponse.<StaffResponse>builder()
                .message("Update member to staff successfully")
                .statusCode(200)
                .isSuccess(true)
                .data(staffService.updateMemberToStaff(id))
                .build()
        );
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_STAFF')")
    public ResponseEntity<ApiResponse<StaffResponse>> updateStaff(
        @PathVariable long id,
        @Valid @RequestBody UserDTO staff,
        BindingResult result) {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        return ResponseEntity.ok(
            ApiResponse.<StaffResponse>builder()
                .message("Update staff successfully")
                .statusCode(200)
                .isSuccess(true)
                .data(staffService.update(id, staff))
                .build()
        );
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public ResponseEntity<ApiResponse<StaffResponse>> deleteStaff(@PathVariable long id) {

        staffService.delete(id);

        return ResponseEntity.ok(
            ApiResponse.<StaffResponse>builder()
                .message("Delete staff successfully")
                .statusCode(200)
                .isSuccess(true)
                .build()
        );
    }

}
