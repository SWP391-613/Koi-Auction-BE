package com.swp391.koibe.domain.user.member;

import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.domain.user.User;
import com.swp391.koibe.domain.user.MemberResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IMemberService {

    Page<MemberResponse> getAllMembers(Pageable pageable);
    User findById(long id) throws DataNotFoundException;

}
