package com.swp391_09.Koi_BE.controllers;

import com.swp391_09.Koi_BE.dtos.UserLoginDTO;
import com.swp391_09.Koi_BE.responses.LoginResponse;
import com.swp391_09.Koi_BE.services.CategoryService;
import com.swp391_09.Koi_BE.services.IUserService;
import com.swp391_09.Koi_BE.services.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/users")
@RequiredArgsConstructor
public class UserController {

    private final IUserService userService;

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody @Valid UserLoginDTO userLoginDTO) {
        try {
            String result = userService.login(userLoginDTO.getEmail(), userLoginDTO.getPassword());
            return ResponseEntity.ok(LoginResponse.builder()
                                         .message(result)
                                         .token("token")
                                         .build());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(
                LoginResponse.builder()
                    .message(e.getMessage())
                    .build()
            );
        }

    }

}
