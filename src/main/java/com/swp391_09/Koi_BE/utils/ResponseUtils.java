package com.swp391_09.Koi_BE.utils;

import com.swp391_09.Koi_BE.responses.LoginResponse;
import org.springframework.http.ResponseEntity;

public class ResponseUtils {

    public static ResponseEntity<LoginResponse> loginSuccess(String message, String token) {
        return ResponseEntity.ok().body(LoginResponse.builder()
                .message(message)
                .token(token)
                .build());
    }

    public static ResponseEntity<LoginResponse> loginFailed(String message) {
        return ResponseEntity.badRequest().body(LoginResponse.builder()
                .message(message)
                .build());
    }

}
