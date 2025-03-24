package com.swp391.koibe.domain.auction;

import com.swp391.koibe.domain.user.UserPort.UserResponse;
import com.swp391.koibe.exceptions.InvalidApiPathVariableException;
import java.util.Set;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("${api.prefix}/auction-participant")
public class AuctionParticipantController {

    private final IAuctionContract auctionContract;

    @GetMapping("/{auctionId}")
    public ResponseEntity<?> getAllUsersJoinAuction(
        @PathVariable long auctionId) {
        if (auctionId <= 0) {
            throw new InvalidApiPathVariableException("Invalid auction id");
        }
        try {
            Set<UserResponse> userList = auctionContract.getAllUserJoinAuction(auctionId);
            return ResponseEntity.ok(userList);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }


    }


}
