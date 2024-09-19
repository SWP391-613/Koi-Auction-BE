package com.swp391_09.Koi_BE.services.member;

import com.swp391_09.Koi_BE.models.User;
import com.swp391_09.Koi_BE.repositories.UserRepository;
import com.swp391_09.Koi_BE.responses.UserResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService implements IMemberService{

    private final UserRepository userRepository;

    @Override
    public Page<UserResponse> getAllMembers(Pageable pageable) {
        Page<User> members = userRepository.findByRoleName("MEMBER", pageable);
        return members.map(UserResponse::convertToDTO);
    }

    @Override
    public User getMemberById(long id) {
        return null;
    }

    @Override
    public User createMember(User member) {
        return null;
    }

    @Override
    public User updateMember(long memberId, User member) {
        return null;
    }

    @Override
    public void deleteMember(long id) {

    }
}
