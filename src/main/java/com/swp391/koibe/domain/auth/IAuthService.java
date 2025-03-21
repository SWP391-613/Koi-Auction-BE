package com.swp391.koibe.domain.auth;

import com.swp391.koibe.domain.token.TokenPort;

public interface IAuthService {

    AuthPort.LoginResponse refreshToken(TokenPort.RefreshTokenDTO refreshTokenDTO) throws Exception;

}
