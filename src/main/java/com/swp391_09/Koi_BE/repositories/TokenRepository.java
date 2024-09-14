package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.Token;
import com.swp391_09.Koi_BE.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TokenRepository extends JpaRepository<Token, Long> {
    List<Token> findByUser(User user);
    Token findByToken(String token);
    Token findByRefreshToken(String token);
}

