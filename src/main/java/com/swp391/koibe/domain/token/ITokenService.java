package com.swp391.koibe.domain.token;

import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.domain.user.User;
import org.springframework.stereotype.Service;

@Service

public interface ITokenService {
    Token addToken(User user, String token, boolean isMobileDevice);
    Token refreshToken(String refreshToken, User user) throws Exception;
    void deleteToken(String token, User user) throws DataNotFoundException;
    Token findUserByToken(String token) throws DataNotFoundException;
    void setTokenExpired();
}
