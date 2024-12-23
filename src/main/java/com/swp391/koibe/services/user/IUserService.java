package com.swp391.koibe.services.user;

import com.swp391.koibe.dtos.UpdatePasswordDTO;
import com.swp391.koibe.dtos.UpdateUserDTO;
import com.swp391.koibe.dtos.UserRegisterDTO;
import com.swp391.koibe.dtos.auctionkoi.AuctionKoiDTO;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.User;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

public interface IUserService {

    User createUser(UserRegisterDTO userRegisterDTO) throws Exception;

    String login(String email, String password) throws Exception;

    String loginOrRegisterGoogle(String email, String name, String googleId, String avatarUrl) throws Exception;

    User getUserById(long id) throws DataNotFoundException;

    User getUserByEmail(String email) throws DataNotFoundException;

    List<User> getAllUsers();

    User findByUsername(String username) throws DataNotFoundException;

    Page<User> findAll(String keyword, Pageable pageable) throws Exception;

    void blockOrEnable(Long userId, Boolean active) throws DataNotFoundException;

    @Transactional
    User updateUser(Long userId, UpdateUserDTO updatedUserDTO) throws Exception;

    @Transactional
    User updateUserBalance(Long userId, Long payment) throws Exception;

    void updateAccountBalance(Long userId, Long payment) throws Exception;

    // Token
    User getUserDetailsFromToken(String token) throws Exception;

    // Otp
    void verifyOtpToVerifyUser(Long userId, String otp) throws Exception;

    void verifyOtpIsCorrect(Long userId, String otp) throws Exception;

    void bannedUser(Long userId) throws DataNotFoundException;

    void updatePassword(UpdatePasswordDTO updatePasswordDTO) throws Exception;

    void softDeleteUser(Long userId) throws DataNotFoundException;

    void restoreUser(Long userId) throws DataNotFoundException;

    void updateRole(long id, long roleId) throws DataNotFoundException;

    void validateAccountBalance(User user, long basePrice);
}
