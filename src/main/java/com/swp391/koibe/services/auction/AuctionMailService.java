package com.swp391.koibe.services.auction;

import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.responses.AuctionResponse;
import com.swp391.koibe.responses.UserResponse;
import com.swp391.koibe.services.auctionparticipant.AuctionParticipantService;
import com.swp391.koibe.services.mail.IMailService;
import jakarta.mail.MessagingException;
import java.util.Set;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;

@Service
@RequiredArgsConstructor
public class AuctionMailService implements IAuctionMailService {

    private final IAuctionService auctionService;
    private final AuctionParticipantService auctionParticipantService;
    private final IMailService mailService;

    @Override
    public void sendAuctionClosedEmailToAllUser(long auctionId,
                                                String subject,
                                                String templateName,
                                                Context context) throws MessagingException {

        AuctionResponse existingAuction = auctionService.getById(auctionId);

        if (existingAuction == null) {
            throw new DataNotFoundException("Auction not found");
        }

        context.setVariable("auction_title", existingAuction.getTitle());
        context.setVariable("auction_end_date", existingAuction.getEndTime());
        context.setVariable("auction_url", "http://localhost:3000/auctions/" + auctionId);

        Set<UserResponse> userList = auctionParticipantService.getAllUserJoinAuction(auctionId);

        for (UserResponse user : userList) {
            // Clone the original context by creating a new context and manually copying the variables
            Context userContext = new Context();
            // Manually copy variables
            userContext.setVariable("auction_title", existingAuction.getTitle());
            userContext.setVariable("auction_end_date", existingAuction.getEndTime());
            userContext.setVariable("auction_url", "http://localhost:3000/auctions/" + auctionId);

            // Set user-specific variables
            String name = user.getFirstName();
            String to = user.getEmail();
            userContext.setVariable("name", name);

            mailService.sendMail(to, subject, templateName, userContext);
        }
    }
}
