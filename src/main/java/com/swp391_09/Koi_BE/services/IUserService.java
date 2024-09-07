package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.dtos.UserRegisterDTO;
import com.swp391_09.Koi_BE.models.User;

public interface IUserService {

    User createUser(UserRegisterDTO userRegisterDTO) throws Exception;
    String login(String email, String password) throws Exception;

}
