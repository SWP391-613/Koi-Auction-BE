package com.swp391.koibe.domain.user.staff;

import com.swp391.koibe.dtos.StaffRegisterDTO;
import com.swp391.koibe.dtos.UserDTO;
import com.swp391.koibe.exceptions.PermissionDeniedException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.dtos.responses.StaffResponse;
import com.swp391.koibe.api.PageResponse;
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
