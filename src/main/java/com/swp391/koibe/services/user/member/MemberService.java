package com.swp391.koibe.services.user.member;

import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.exceptions.MemberNotFoundException;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.responses.MemberResponse;
import com.swp391.koibe.services.user.IUserService;
import com.swp391.koibe.utils.DTOConverter;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService implements IMemberService{

    private final UserRepository userRepository;
    private final DTOConverter dtoConverter;
    private final IUserService userService;

    @Override
    public Page<MemberResponse> getAllMembers(Pageable pageable) {
        Page<User> members = userRepository.findAllMember(pageable);
        return members.map(dtoConverter::toMemberResponse);
    }

    @Override
    public User findById(long id) throws DataNotFoundException {
        Optional<User> member = userRepository.findById(id);
        User existingMember;
        if(member.isEmpty()){
            throw new MemberNotFoundException("Member not found");
        }else{
            existingMember = member.get();
            if(existingMember.getRole().getId() != 1){
                throw new MemberNotFoundException("Member not found");
            }

        }

        return existingMember;
    }

}
