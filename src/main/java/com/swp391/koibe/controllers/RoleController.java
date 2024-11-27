package com.swp391.koibe.controllers;

import com.swp391.koibe.dtos.RoleDTO;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.responses.RoleResponse;
import com.swp391.koibe.responses.base.ApiResponse;
import com.swp391.koibe.services.role.IRoleService;
import jakarta.validation.Valid;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/roles")
@RequiredArgsConstructor
@Slf4j
public class RoleController {

    private final IRoleService roleService;

    @GetMapping("")
    public ResponseEntity<ApiResponse<List<RoleResponse>>> getAllRoles() {
        return ResponseEntity.status(HttpStatus.OK).body(
            ApiResponse.<List<RoleResponse>>builder()
                .message("Roles fetched successfully")
                .data(roleService.getAllRoles())
                .statusCode(HttpStatus.OK.value())
                .isSuccess(true)
                .build()
        );
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<RoleResponse>> getRoleById(@PathVariable Long id) {
        return ResponseEntity.status(HttpStatus.OK).body(
            ApiResponse.<RoleResponse>builder()
                .message("Role fetched successfully")
                .data(roleService.getRoleById(id))
                .statusCode(HttpStatus.OK.value())
                .isSuccess(true)
                .build()
        );
    }

    @PostMapping("")
    public ResponseEntity<ApiResponse<RoleResponse>> createRole(
        @Valid @RequestBody RoleDTO roleDTO,
        BindingResult bindingResult) {

        // Check if there are validation errors
        if (bindingResult.hasErrors()) {
            throw new MethodArgumentNotValidException(bindingResult);
        }

        return ResponseEntity.status(HttpStatus.CREATED).body(
            ApiResponse.<RoleResponse>builder()
                .message("Role created successfully")
                .data(roleService.createRole(roleDTO))
                .statusCode(HttpStatus.CREATED.value())
                .isSuccess(true)
                .build());

    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<RoleResponse>> updateRole(
        @PathVariable Long id,
        @Valid @RequestBody RoleDTO roleDTO) {
        roleService.updateRole(id, roleDTO);
        return ResponseEntity.ok(
            ApiResponse.<RoleResponse>builder()
                .message("Role updated successfully")
                .data(roleService.getRoleById(id))
                .statusCode(HttpStatus.OK.value())
                .isSuccess(true)
                .build()
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<RoleResponse>> deleteRole(@PathVariable Long id) {
        roleService.deleteRole(id);
        return ResponseEntity.ok(
            ApiResponse.<RoleResponse>builder()
                .message("Role deleted successfully")
                .statusCode(HttpStatus.OK.value())
                .isSuccess(true)
                .data(null)
                .build()
        );
    }

}
