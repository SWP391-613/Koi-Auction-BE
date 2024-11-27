package com.swp391.koibe.services.biddinghistory;

import com.swp391.koibe.models.AuctionKoi;
import com.swp391.koibe.models.Bid;
import com.swp391.koibe.models.User;
import com.swp391.koibe.services.mail.IMailService;
import com.swp391.koibe.services.user.UserService;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;

import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class BiddingHistoryEmailService implements IBiddingHistoryEmailService {

    private final IMailService mailService;
    private final IBiddingHistoryService biddingHistoryService;
    private final UserService userService;

    @Retryable(
            retryFor = {MessagingException.class},  // Retry only for specific exceptions
            maxAttempts = 3,                       // Maximum retry attempts
            backoff = @Backoff(delay = 2000)       // 2 seconds delay between retries
    )
    public void sendRefundEmail(AuctionKoi auctionKoi, String subject, String templateName, Context context) throws MessagingException {
        Long winnerBidderId = auctionKoi.getCurrentBidderId();
        if (winnerBidderId != null && winnerBidderId != 0) {
            List<Bid> bids = biddingHistoryService.getBidsByAuctionKoiId(auctionKoi.getId());

            // Create map of bidder IDs and their latest bids directly from bids list
            Map<Long, Bid> bidderLatestBids = bids.stream()
                    .filter(bid -> !bid.getBidder().getId().equals(winnerBidderId))
                    .collect(Collectors.groupingBy(
                            bid -> bid.getBidder().getId(),
                            Collectors.collectingAndThen(
                                    Collectors.maxBy(Comparator.comparing(Bid::getBidTime)),
                                    Optional::get
                            )
                    ));

            // Process refunds
            for (Map.Entry<Long, Bid> entry : bidderLatestBids.entrySet()) {
                try {
                    User user = userService.getUserById(entry.getKey());
                    context.setVariable("name", user.getFirstName() + " " + user.getLastName());
                    context.setVariable("auction_title", auctionKoi.getAuction().getTitle());
                    context.setVariable("auction_end_date", auctionKoi.getAuction().getEndTime());
                    context.setVariable("user_bid", entry.getValue().getBidAmount());
                    context.setVariable("auction_url", "http://localhost:3000/auctions/" + auctionKoi.getAuction().getId());
                    mailService.sendMail(user.getEmail(), subject, templateName, context);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }
}
