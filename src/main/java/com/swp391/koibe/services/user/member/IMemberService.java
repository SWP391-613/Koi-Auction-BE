package com.swp391.koibe.services.user.member;

import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.MemberResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IMemberService {

    Page<MemberResponse> getAllMembers(Pageable pageable);
    User findById(long id) throws DataNotFoundException;

}
