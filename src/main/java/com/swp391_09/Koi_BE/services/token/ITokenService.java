package com.swp391_09.Koi_BE.services.token;

import com.swp391_09.Koi_BE.models.Token;
import com.swp391_09.Koi_BE.models.User;
import org.springframework.stereotype.Service;

@Service

public interface ITokenService {
    Token addToken(User user, String token, boolean isMobileDevice);
    Token refreshToken(String refreshToken, User user) throws Exception;
}
