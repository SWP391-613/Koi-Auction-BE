package com.swp391.koibe.domain.auth;

import com.swp391.koibe.domain.token.TokenPort;
import com.swp391.koibe.domain.user.UserPort;

public interface IAuthService {

    AuthPort.LoginResponse refreshToken(TokenPort.RefreshTokenDTO refreshTokenDTO) throws Exception;
    UserPort.UserResponse getUserDetailsFromToken(String token) throws Exception;
}
