package com.swp391.koibe.services.user;

import com.swp391.koibe.dtos.UserRegisterDTO;
import com.swp391.koibe.models.User;

public interface IUserService {

    User createUser(UserRegisterDTO userRegisterDTO) throws Exception;
    String login(String email, String password) throws Exception;
    String loginOrRegisterGoogle(String email, String name, String googleId, String avatarUrl) throws Exception;
}
