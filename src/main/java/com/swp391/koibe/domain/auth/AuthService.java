package com.swp391.koibe.domain.auth;

import com.swp391.koibe.domain.token.ITokenService;
import com.swp391.koibe.domain.token.Token;
import com.swp391.koibe.domain.token.TokenPort;
import com.swp391.koibe.domain.token.TokenPort.TokenResponse;
import com.swp391.koibe.domain.user.IUserService;
import com.swp391.koibe.domain.user.User;
import com.swp391.koibe.dtos.responses.LoginResponse;
//import com.swp391.koibe.mapper.TokenMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService implements IAuthService{

    private final IUserService userService;
    private final ITokenService tokenService;
//    private final TokenMapper tokenMapper;


    @Override
    public AuthPort.LoginResponse refreshToken(TokenPort.RefreshTokenDTO refreshTokenDTO) throws Exception {
        User userDetail = userService.getUserDetailsFromRefreshToken(
            refreshTokenDTO.refreshToken());
        Token jwtToken = tokenService.refreshToken(refreshTokenDTO.refreshToken(), userDetail);
        return new AuthPort.LoginResponse(
            new TokenResponse(
                jwtToken.getId(),
                jwtToken.getToken(),
                jwtToken.getRefreshToken(),
                jwtToken.getTokenType(),
                jwtToken.getExpirationDate(),
                jwtToken.getRefreshExpirationDate(),
                jwtToken.isMobile(),
                jwtToken.isRevoked(),
                jwtToken.isExpired())
        );
    }

}
