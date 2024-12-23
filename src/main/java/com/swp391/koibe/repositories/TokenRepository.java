package com.swp391.koibe.repositories;

import com.swp391.koibe.models.Token;
import com.swp391.koibe.models.User;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface TokenRepository extends JpaRepository<Token, Long> {
    List<Token> findByUser(User user);
    Token findByToken(String token);
    Token findByRefreshToken(String token);

     @Modifying
     @Query("UPDATE Token t SET t.expired = true WHERE t.expirationDate < :now AND t.expired = false")
    void updateExpiredTokens(LocalDateTime now);


}
