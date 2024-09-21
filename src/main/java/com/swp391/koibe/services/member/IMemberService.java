package com.swp391.koibe.services.member;

import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.UserResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IMemberService {

    Page<UserResponse> getAllMembers(Pageable pageable);
    User getMemberById(long id);
    User createMember(User member);
    User updateMember(long memberId, User member);
    void deleteMember(long id);

}
