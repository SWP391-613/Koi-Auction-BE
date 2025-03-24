package com.swp391.koibe.domain.user.staff;

import com.swp391.koibe.api.PageResponse;
import com.swp391.koibe.domain.user.UserPort.StaffRegisterDTO;
import com.swp391.koibe.domain.user.UserPort.StaffResponse;
import com.swp391.koibe.domain.user.UserPort.UserDTO;
import com.swp391.koibe.exceptions.PermissionDeniedException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
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
