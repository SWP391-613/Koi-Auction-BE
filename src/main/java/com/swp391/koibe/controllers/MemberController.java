package com.swp391.koibe.controllers;

import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.UserResponse;
import com.swp391.koibe.services.member.IMemberService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("${api.prefix}/members")
public class MemberController {

    private final IMemberService memberService;

    @GetMapping("")
    public ResponseEntity<List<UserResponse>> getAllMembers(
        @RequestParam("page") int page,
        @RequestParam("limit") int limit
    ) {
        try {
            PageRequest pageRequest = PageRequest.of(page, limit);
            Page<UserResponse> members = memberService.getAllMembers(pageRequest);
            return ResponseEntity.ok(members.getContent());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

}
