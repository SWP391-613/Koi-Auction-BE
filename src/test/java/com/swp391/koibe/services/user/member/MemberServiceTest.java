package com.swp391.koibe.services.user.member;

import com.swp391.koibe.domain.user.member.MemberService;
import com.swp391.koibe.domain.role.Role;
import com.swp391.koibe.domain.user.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test")
class MemberServiceTest {

    @MockBean
    private MemberService memberService;

    @BeforeEach
    void setUp() {
        Mockito.reset(memberService);
    }

    private final Role memberRole = Role.builder()
        .id(1L)
        .build();

    @Test
    void getAllMembers() {

    }

    @Test
    void findById() {

        User member = User.builder().id(1L).role(memberRole).build();
        Mockito.when(memberService.findById(1L))
            .thenReturn(member);

    }

    @Test
    void createMember() {
    }

    @Test
    void updateMember() {
    }

    @Test
    void deleteMember() {
    }
}