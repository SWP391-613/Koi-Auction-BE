package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.models.UserStatus;
import java.util.List;

public interface IUserStatusService {
    UserStatus createUserStatus(int id, String status);
    void updateUserStatus(int id, String status);
    void deleteUserStatus(int id);
    UserStatus getUserStatus(int id);
    List<UserStatus> getAllUserStatus();
}
