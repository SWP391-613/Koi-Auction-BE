package com.swp391.koibe.controllers;

import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.*;
import com.swp391.koibe.repositories.AuctionParticipantRepository;
import com.swp391.koibe.responses.BidResponse;
import com.swp391.koibe.services.auctionkoi.IAuctionKoiService;
import com.swp391.koibe.services.biddinghistory.IBiddingHistoryService;
import com.swp391.koibe.services.user.IUserService;
import com.swp391.koibe.utils.DTOConverter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

import java.util.stream.Collectors;

@Slf4j
@RestController
@RequestMapping("${api.prefix}/auctionkoidetails")
@RequiredArgsConstructor
public class BiddingHistoryController {

    private final IAuctionKoiService auctionKoiService;
    private final IUserService userService;
    private final IBiddingHistoryService biddingHistoryService;
    private final AuctionParticipantRepository auctionParticipantRepository;

    @PostMapping("/generateFakeAuctionKoiDetails")
    public ResponseEntity<String> generateFakeAuctionKoiDetails() {
        try {
            List<AuctionKoi> auctionKois = auctionKoiService.getAuctionIsSold();
            List<User> users = userService.getAllUsers();
            Random random = new Random();

            // Group AuctionKois by Auction
            Map<Auction, List<AuctionKoi>> auctionKoisByAuction = auctionKois.stream()
                    .collect(Collectors.groupingBy(AuctionKoi::getAuction));

            for (Map.Entry<Auction, List<AuctionKoi>> entry : auctionKoisByAuction.entrySet()) {
                Auction auction = entry.getKey();
                List<AuctionKoi> auctionKoisForAuction = entry.getValue();
                Set<Long> participantIds = new HashSet<>();

                for (AuctionKoi auctionKoi : auctionKoisForAuction) {
                    List<Bid> bidHistories = new ArrayList<>();
                    int numberOfBids = random.nextInt(5, 16); // Random number of bids between 5 and 15
                    int currentBidAmount = auctionKoi.getBasePrice().intValue();

                    for (int i = 1; i <= numberOfBids; i++) {
                        long ownerId = auctionKoi.getKoi().getOwner().getId();
                        User bidder = users.stream()
                                .filter(user -> user.getId() != ownerId)
                                .skip(random.nextInt(users.size() - 1))
                                .findFirst()
                                .orElseThrow(() -> new DataNotFoundException("No suitable bidder found"));

                        Bid bid = new Bid();
                        bid.setAuctionKoi(auctionKoi);
                        bid.setBidder(bidder);

                        // Ensure each bid is higher than the previous one
                        currentBidAmount += auctionKoi.getBidStep();
                        bid.setBidAmount(Math.round(currentBidAmount));

                        LocalDateTime bidTime = auctionKoi.getAuction().getStartTime().plusHours(i);
                        bid.setBidTime(bidTime);

                        bidHistories.add(bid);

                        // Add participant if not already added for this auction
                        if (!participantIds.contains(bidder.getId())) {
                            AuctionParticipant participant = new AuctionParticipant();
                            participant.setAuction(auction);
                            participant.setUser(bidder);
                            participant.setJoinTime(bid.getBidTime());
                            auctionParticipantRepository.save(participant);
                            participantIds.add(bidder.getId());
                        }
                    }

                    // Sort bid histories by time
                    bidHistories.sort(Comparator.comparing(Bid::getBidTime));

                    // Set the last bid as the winning bid
                    Bid winningBid = bidHistories.get(bidHistories.size() - 1);
                    auctionKoi.setCurrentBid(winningBid.getBidAmount());
                    auctionKoi.setCurrentBidderId(winningBid.getBidder().getId());

                    // Save all bid histories in batch
                    biddingHistoryService.createBidHistories(bidHistories);

                    // Update the AuctionKoi
                    auctionKoiService.updateAuctionKoi(auctionKoi.getId(), auctionKoi);
                }
            }

            return ResponseEntity.ok("Fake auction koi details and participants generated");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error generating fake auction koi details: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<List<BidResponse>> getBiddingHistoryByAuctionKoiId(@PathVariable long id) {
        List<Bid> bidHistories = biddingHistoryService.getBidsByAuctionKoiId(id);
        List<BidResponse> bidResponses = bidHistories.stream()
                .map(DTOConverter::convertToBidDTO) // Convert Bid to BidResponse
                .collect(Collectors.toList());
        // by bid time newest to oldest
        Comparator<BidResponse> byBidTime = Comparator.comparing(BidResponse::getBidTime).reversed();
        bidResponses.sort(byBidTime);
        return ResponseEntity.ok(bidResponses);
    }

    @PostMapping("/auctionkois{auction_koi_id}/auction/{auction_id}")
    //localhost:8080/api/v1/auctionkoidetails/auctionkois/1/auction/1
    public ResponseEntity<?> createBiddingHistory(@PathVariable long auction_koi_id, @PathVariable long auction_id, @RequestBody Bid bid) {
        try {
            AuctionKoi auctionKoi = auctionKoiService.getAuctionKoiById(auction_koi_id);
            if (auctionKoi.getAuction().getId() != auction_id) {
                return ResponseEntity.badRequest()
                    .body("Auction koi does not belong to the auction");
            }

            // Check if the bid amount is higher than the current bid
            if (bid.getBidAmount() <= auctionKoi.getCurrentBid()) {
                return ResponseEntity.badRequest()
                    .body("Bid amount must be higher than the current bid");
            }

            // Check if the bid amount is a multiple of the bid step
            if ((bid.getBidAmount() - auctionKoi.getCurrentBid()) % auctionKoi.getBidStep() != 0) {
                return ResponseEntity.badRequest()
                    .body("Bid amount must be a multiple of the bid step");
            }

            // Check if the auction is still ongoing
            LocalDateTime now = LocalDateTime.now();
            if (now.isBefore(auctionKoi.getAuction().getStartTime()) || now.isAfter(
                auctionKoi.getAuction().getEndTime())) {
                return ResponseEntity.badRequest().body("Auction is not ongoing");
            }

            // Check if the bidder is the owner of the koi
            if (bid.getBidder().getId() == auctionKoi.getKoi().getOwner().getId()) {
                return ResponseEntity.badRequest().body("Owner of the koi cannot bid");
            }

            // Check if the bidder has already placed a bid
            if (biddingHistoryService.hasBid(auction_koi_id, bid.getBidder().getId())) {
                return ResponseEntity.badRequest().body("Bidder has already placed a bid");
            }

            // Create the bidding history
            bid.setAuctionKoi(auctionKoi);
            biddingHistoryService.createBidHistory(bid);

            // Update the current bid and current bidder of the auction koi
            auctionKoi.setCurrentBid(bid.getBidAmount());
            auctionKoi.setCurrentBidderId(bid.getBidder().getId());
            auctionKoiService.updateAuctionKoi(auction_koi_id, auctionKoi);

            return ResponseEntity.status(HttpStatus.CREATED).body("Bid created successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }


}
