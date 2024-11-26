package com.swp391.koibe.services.user.staff;

import com.swp391.koibe.dtos.StaffRegisterDTO;
import com.swp391.koibe.dtos.UserDTO;
import com.swp391.koibe.dtos.UserRegisterDTO;
import com.swp391.koibe.exceptions.PermissionDeniedException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.StaffResponse;
import com.swp391.koibe.responses.UserResponse;
import com.swp391.koibe.responses.base.PageResponse;
import jakarta.mail.MessagingException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IStaffService {

    PageResponse<StaffResponse> getAllStaffs(Pageable pageable);
    StaffResponse findById(long id) throws DataNotFoundException;
    StaffResponse createNewStaff(StaffRegisterDTO staff) throws PermissionDeniedException;
    StaffResponse updateMemberToStaff(long id);
    StaffResponse update(long id, UserDTO staff);
    void delete(long id);
    PageResponse<StaffResponse> findAllStaffWithActive(Pageable pageable);

}
