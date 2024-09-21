package com.swp391.koibe.controllers;

import com.swp391.koibe.components.LocalizationUtils;
import com.swp391.koibe.dtos.UserLoginDTO;
import com.swp391.koibe.dtos.UserRegisterDTO;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.LoginResponse;
import com.swp391.koibe.responses.RegisterResponse;
import com.swp391.koibe.services.user.IUserService;
import com.swp391.koibe.utils.MessageKeys;
import com.swp391.koibe.utils.ResponseUtils;
import jakarta.validation.Valid;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final IUserService userService;
    private final LocalizationUtils localizationUtils;

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(
        @RequestBody @Valid UserLoginDTO userLoginDTO,
        BindingResult result) {

        if (result.hasErrors()) {
            List<FieldError> fieldErrorList = result.getFieldErrors();
            List<String> errorMessages = fieldErrorList
                .stream()
                .map(FieldError::getDefaultMessage)
                .toList();
            return ResponseEntity.badRequest().body(LoginResponse.builder()
                                                        .message(errorMessages.toString())
                                                        .build());
        }

        String token;
        try {
            token = userService.login(userLoginDTO.getEmail(), userLoginDTO.getPassword());
            log.info("User logged in successfully");
            return ResponseUtils.loginSuccess(localizationUtils.getLocalizedMessage(MessageKeys.LOGIN_SUCCESSFULLY), token);
        } catch (Exception e) {
            return ResponseUtils.loginFailed(localizationUtils.getLocalizedMessage(MessageKeys.LOGIN_FAILED, e.getMessage()));
        }

    }

    @PostMapping("/register")
    public ResponseEntity<RegisterResponse> createUser(
        @RequestBody @Valid UserRegisterDTO userRegisterDTO,
        BindingResult result) {

        if (result.hasErrors()) {
            List<FieldError> fieldErrorList = result.getFieldErrors();
            List<String> errorMessages = fieldErrorList
                .stream()
                .map(FieldError::getDefaultMessage)
                .toList();
            return ResponseEntity.badRequest().body(RegisterResponse.builder()
                                                        .message(errorMessages.toString())
                                                        .build());
        }

        if (!userRegisterDTO.getPassword().equals(userRegisterDTO.getRetypePassword())) {
            return ResponseEntity.badRequest()
                .body(RegisterResponse.builder()
                          .message(localizationUtils.getLocalizedMessage(MessageKeys.PASSWORD_NOT_MATCH))
                          .build());
        }

        try {
            User user = userService.createUser(userRegisterDTO);
            log.info("New user registered successfully");
            return ResponseEntity.ok(
                RegisterResponse.builder()
                    .message("Register success")
                    .user(user)
                    .build()
            );
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(
                RegisterResponse.builder()
                    .message(e.getMessage())
                    .build()
            );
        }
    }

}
