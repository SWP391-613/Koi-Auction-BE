package com.swp391.koibe.domain.auction;

import com.swp391.koibe.api.PageResponse;
import com.swp391.koibe.domain.bidding.BidMethodQuantityResponse;
import com.swp391.koibe.domain.koi.Koi;
import com.swp391.koibe.domain.koi.KoiInAuctionResponse;
import com.swp391.koibe.domain.mail.IMailService;
import com.swp391.koibe.domain.user.IUserService;
import com.swp391.koibe.domain.user.User;
import com.swp391.koibe.domain.user.UserPort.UserResponse;
import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.enums.EBidMethod;
import com.swp391.koibe.enums.EmailCategoriesEnum;
import com.swp391.koibe.exceptions.DeleteException;
import com.swp391.koibe.exceptions.MalformBehaviourException;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.metadata.PaginationMeta;
import com.swp391.koibe.repositories.AuctionKoiRepository;
import com.swp391.koibe.repositories.AuctionParticipantRepository;
import com.swp391.koibe.repositories.AuctionRepository;
import com.swp391.koibe.repositories.KoiRepository;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.utils.DTOConverter;
import com.swp391.koibe.utils.DateTimeUtils;
import jakarta.mail.MessagingException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thymeleaf.context.Context;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = lombok.AccessLevel.PRIVATE, makeFinal = true)
public class AuctionContract implements IAuctionContract{

    AuctionKoiRepository auctionKoiRepository;
    AuctionRepository auctionRepository;
    UserRepository userRepository;
    AuctionParticipantRepository auctionParticipantRepository;
    KoiRepository koiRepository;
    IUserService userService;
    IMailService mailService;

    //Auction
    @Override
    public AuctionResponse createAscendingAuction(AuctionPort.AuctionDTO auctionDTO) throws DataAlreadyExistException {
        LocalDateTime startTime = DateTimeUtils.parseTime(auctionDTO.startTime());
        LocalDateTime endTime = DateTimeUtils.parseTime(auctionDTO.endTime());
        DateTimeUtils.validateAuctionTimes(startTime, endTime);

        if (auctionDTO.statusName() == EAuctionStatus.ENDED) {
            throw new MalformDataException("Cannot create ended auction");
        }

        if (auctionDTO.statusName() == EAuctionStatus.ONGOING) {
            throw new MalformDataException("Cannot create ongoing auction");
        }

        User existingUser = userRepository.findStaffById(auctionDTO.auctioneerId())
            .orElseThrow(() -> new MalformDataException("Auctioneer not found"));

        Auction newAuction = Auction.builder()
            .title(auctionDTO.title())
            .startTime(startTime)
            .endTime(endTime)
            .status(auctionDTO.statusName())
            .auctioneer(existingUser)
            .build();

        return DTOConverter.toAuctionResponse(auctionRepository.save(newAuction));
    }

    @Override
    public AuctionResponse getAuctionById(long id) throws DataNotFoundException {
        return auctionRepository.findById(id)
            .map(auction -> DTOConverter.toAuctionResponse(auction, getAuctionKoiByAuctionId(id)))
            .orElseThrow(() -> new DataNotFoundException("Auction not found"));
    }


    @Override
    public AuctionResponse update(long auctionId, UpdateAuctionDTO updateAuctionDTO)
        throws DataNotFoundException {
        Auction auction = auctionRepository.findById(auctionId)
            .orElseThrow(() -> new DataNotFoundException("Auction not found"));

        //cannot update auction with status ended or ongoing
        if (auction.getStatus().equals(EAuctionStatus.ENDED) || auction.getStatus()
            .equals(EAuctionStatus.ONGOING)) {
            throw new MalformDataException("Cannot update ended or ongoing auction");
        }

        LocalDateTime startTime = DateTimeUtils.parseTime(updateAuctionDTO.startTime());
        LocalDateTime endTime = DateTimeUtils.parseTime(updateAuctionDTO.endTime());
        DateTimeUtils.validateUpdateAuctionTimes(startTime, endTime);

        // check if status name is valid
        boolean isValidStatus = Arrays.stream(EAuctionStatus.values())
            .anyMatch(status -> status.name().equals(updateAuctionDTO.statusName()));

        if (!isValidStatus) {
            throw new MalformDataException("Invalid auction status name");
        }

        //can update the auction to any status

        User existingUser = userRepository.findStaffById(updateAuctionDTO.auctioneerId())
            .orElseThrow(() -> new MalformDataException("Auctioneer not found"));

        auction.setTitle(updateAuctionDTO.title());
        auction.setStartTime(startTime);
        auction.setEndTime(endTime);
        auction.setStatus(EAuctionStatus.valueOf(updateAuctionDTO.statusName()));
        auction.setAuctioneer(existingUser);

        return DTOConverter.toAuctionResponse(auctionRepository.save(auction));
    }

    @Override
    public void delete(long id) {
        Auction auction = auctionRepository.findById(id)
            .orElseThrow(() -> new DataNotFoundException("Auction not found"));

        //check if auction has joined participants
        if (!auctionParticipantRepository.getAuctionParticipantsByAuctionId(id).isEmpty()) {
            throw new DeleteException("Cannot delete auction with joined participants");
        }

        //check if auction has joined koi
        if (!auctionKoiRepository.findAuctionKoiByAuctionId(id).isEmpty()) {
            throw new DeleteException("Cannot delete auction with joined koi");
        }

        if (auction.getStatus().equals(EAuctionStatus.ONGOING)) {
            throw new DeleteException("Cannot delete ongoing auction");
        }

        //only delete in case auction has no joined participants, koi added
        auctionRepository.delete(auction);
    }

    @Override
    public void end(long id) throws DataNotFoundException {
        Auction auction = auctionRepository.findById(id)
            .orElseThrow(() -> new DataNotFoundException("Auction not found"));
        if (auction.getStatus() == EAuctionStatus.ENDED) {
            throw
                new MalformDataException("Auction already ended");
        }
        LocalDateTime now = LocalDateTime.now();
        auction.setEndTime(now);
        auctionRepository.save(auction);
    }

    @Override
    public List<Auction> getAuctionByStatus(EAuctionStatus status) {
        return auctionRepository.findAllByStatus(status);
    }

    @Override
    public boolean updateAuctionStatus(Auction auction) throws DataNotFoundException {
        boolean isUpdated = false;
        if (auction.getStatus().equals((EAuctionStatus.UPCOMING))) {
            if (auction.getStartTime().isBefore(LocalDateTime.now()) &&
                auction.getEndTime().isAfter(LocalDateTime.now())) {
                auction.setStatus(EAuctionStatus.ONGOING);
                isUpdated = true;
            }
        }

        if (auction.getEndTime().isBefore(LocalDateTime.now()) &&
            auction.getStatus().equals(EAuctionStatus.ONGOING)) {
            auction.setStatus(EAuctionStatus.ENDED);
            isUpdated = true;
        }

        auctionRepository.save(auction);
        return isUpdated;
    }

    @Override
    public Set<Auction> getAuctionOnStatus(EAuctionStatus status) {
        return auctionRepository.findAuctionsByStatus(status);
    }

    @Override
    public List<AuctionResponse> getAuctionByAuctioneerId(long auctioneerId)
        throws DataNotFoundException {
        userRepository.findStaffById(auctioneerId)
            .orElseThrow(() -> new DataNotFoundException("Auctioneer not found"));

        return auctionRepository.findAuctionByAuctioneerId(auctioneerId)
            .stream().map(DTOConverter::toAuctionResponse)
            .collect(Collectors.toList());
    }

    @Override
    public PageResponse<AuctionResponse> getAuctionByKeyword(String keyword, EAuctionStatus status, Pageable pageable) {

        Page<Auction> auctions = auctionRepository.getAuctionByKeyword(keyword, status, pageable);

        List<AuctionResponse> auctionResponses = auctions.stream()
            .map(DTOConverter::toAuctionResponse)
            .toList();

        return PageResponse.<AuctionResponse>pageBuilder()
            .message("Get all auctions successfully")
            .data(auctionResponses)
            .pagination(PaginationMeta.builder()
                            .totalPages(auctions.getTotalPages())
                            .totalItems(auctions.getTotalElements())
                            .currentPage(auctions.getNumber())
                            .pageSize(auctions.getSize())
                            .build())
            .isSuccess(true)
            .statusCode(HttpStatus.OK.value())
            .build();
    }

    @Override
    public AuctionStatusCountResponse countAuctionByStatus() {
        List<Auction> auctions = auctionRepository.findAll();

        long upcoming = auctions.stream()
            .filter(auction -> auction.getStatus().equals(EAuctionStatus.UPCOMING)).count();

        long ongoing = auctions.stream()
            .filter(auction -> auction.getStatus().equals(EAuctionStatus.ONGOING)).count();

        long ended = auctions.stream()
            .filter(auction -> auction.getStatus().equals(EAuctionStatus.ENDED)).count();

        return new AuctionStatusCountResponse(auctions.size(), upcoming, ongoing, ended);
    }

    //AuctionKoi
    @Override
    public AuctionKoi createAuctionKoi(AuctionKoiPort.AuctionKoiDTO auctionKoiDTO)
        throws DataNotFoundException, MessagingException {

        // check if the koi is already in another upcoming auction
        Set<Auction> currentAuctionList = auctionRepository.findAuctionsByStatus(EAuctionStatus.UPCOMING);
        currentAuctionList.addAll(auctionRepository.findAuctionsByStatus(EAuctionStatus.ONGOING));
        for (Auction auction : currentAuctionList) {
            List<AuctionKoi> auctionKoiList = auctionKoiRepository.findAuctionKoiByAuctionId(auction.getId());
            for (AuctionKoi auctionKoi : auctionKoiList) {
                if (Objects.equals(auctionKoi.getKoi().getId(), auctionKoiDTO.koiId())) {
                    throw new MalformDataException("This koi is already in another auction");
                }
            }
        }

        // check if the auction is already include this koi
        List<AuctionKoi> auctionKois = auctionKoiRepository.findAuctionKoiByAuctionId(
            auctionKoiDTO.auctionId());
        for (AuctionKoi auctionKoi : auctionKois) {
            if (Objects.equals(auctionKoi.getKoi().getId(), auctionKoiDTO.koiId())) {
                throw new MalformDataException("This koi is already in this auction");
            }
            // this will ensure that if the koi are in auction (already defined it) then
            // it will not be added to the auction again
            // prevent duplicate koi in auction and different bid method on the same koi in
            // the same auction
        }

        // check if auction exists
        auctionRepository.findById(auctionKoiDTO.auctionId())
            .orElseThrow(() -> new DataNotFoundException("Auction not found"));

        // check auction status is not ended
        AuctionResponse auction = getAuctionById(auctionKoiDTO.auctionId());
        if (auction.status() == EAuctionStatus.ENDED || auction.status() == EAuctionStatus.ONGOING) {
            throw new MalformDataException("Auction are not allow to register");
        }

        // check if koi exists
        Optional<Koi> existingKoi = koiRepository.findById(auctionKoiDTO.koiId());
        if (existingKoi.isEmpty()) {
            throw new DataNotFoundException("Koi not found");
        }

        // Validate ceil price based on bid method
        Long validCeilPrice = null;
        if (EBidMethod.valueOf(auctionKoiDTO.bidMethod()) == EBidMethod.DESCENDING_BID ||
            EBidMethod.valueOf(auctionKoiDTO.bidMethod()) == EBidMethod.ASCENDING_BID) {
            if (auctionKoiDTO.ceilPrice() == null) {
                throw new MalformDataException("Ceil price is required for DESCENDING_BID and ASCENDING_BID");
            }
            validCeilPrice = auctionKoiDTO.ceilPrice(); // Set the provided ceil price

            if (validCeilPrice <= auctionKoiDTO.basePrice()) {
                throw new MalformDataException("Ceil price must be greater than base price");
            }

        }

        Long currentBidValue = auctionKoiDTO.currentBid() != null ? auctionKoiDTO.currentBid() : 0L;

        if (auctionKoiDTO.bidMethod().equals("DESCENDING_BID")) {
            currentBidValue = validCeilPrice;
        }

        AuctionResponse validAuction = getAuctionById(auctionKoiDTO.auctionId());

        // save auction koi
        AuctionKoi newAuctionKoi = AuctionKoi.builder()
            .basePrice(auctionKoiDTO.basePrice())
            .bidStep(auctionKoiDTO.bidStep())
            .bidMethod(EBidMethod.valueOf(auctionKoiDTO.bidMethod()))
            .ceilPrice(validCeilPrice)
            .isSold(false) // default is false when add new koi to auction (if sold, update later)
            .currentBid(currentBidValue)
            .currentBidderId(
                auctionKoiDTO.currentBidderId() != null ? auctionKoiDTO.currentBidderId() : 0L)
            .revoked(0) // default is 0 when add new koi to auction
            .auction(
                Auction.builder().id(validAuction.id())
                    .title(validAuction.title())
                    .startTime(validAuction.startTime())
                    .endTime(validAuction.endTime())
                    .status(validAuction.status())
                    .auctioneer(User.builder().id(validAuction.auctioneerId()).build())
                    .build()
            )
            .koi(existingKoi.get())
            .build();

        User owner = existingKoi.get().getOwner();

        Context context = new Context();
        context.setVariable("name", owner.getFirstName());
        context.setVariable("koiName", existingKoi.get().getName());

        mailService.sendMail(
            owner.getEmail(),
            "Your koi has been added to an auction",
            EmailCategoriesEnum.KOI_ADDED_TO_AUCTION.getType(),
            context);

        return auctionKoiRepository.save(newAuctionKoi);
    }

    @Override
    public AuctionKoi getAuctionKoiById(long id) throws DataNotFoundException {
        return auctionKoiRepository.findById(id)
            .orElseThrow(() -> new DataNotFoundException("Auction Koi not found"));
    }

    @Override
    public List<AuctionKoi> getAuctionKoiByAuctionIdV2(long id) {
        return auctionKoiRepository.findAuctionKoiByAuctionId(id);
    }

    @Override
    public void updateDescendAuctionKoiPrice(long auctionKoiId, AuctionKoi auctionKoi) {
        AuctionKoi auctionKoiToUpdate = auctionKoiRepository.findById(auctionKoiId)
            .orElseThrow(() -> new DataNotFoundException("Auction Koi not found"));

        if (auctionKoiToUpdate.getBidMethod().equals(EBidMethod.DESCENDING_BID)) {
            if (auctionKoiToUpdate.getCurrentBid() > auctionKoiToUpdate.getBasePrice()) {
                auctionKoiToUpdate.setCurrentBid(
                    auctionKoiToUpdate.getCurrentBid() - auctionKoiToUpdate.getBidStep());
            } else {
                auctionKoiToUpdate.setCurrentBid(auctionKoiToUpdate.getBasePrice());
            }
            auctionKoiRepository.save(auctionKoiToUpdate);
        }
    }

    @Transactional
    @Override
    public void revokeKoiInAuction(long koiId, long auctionId) {
        AuctionKoi auctionKoi = auctionKoiRepository.findAuctionKoiByAuctionId(auctionId).stream()
            .filter(ak -> ak.getKoi().getId() == koiId).findFirst()
            .orElseThrow(() -> new DataNotFoundException(String.format("""
                        KoiId %d not found in auctionId "%d"
                        """, koiId, auctionId)));

        if (auctionKoi.getRevoked() == 1){
            throw new MalformBehaviourException("Koi is already revoked");
        }

        auctionKoi.setRevoked(1); // soft delete
        auctionKoiRepository.save(auctionKoi);
    }

    @Override
    public Page<KoiInAuctionResponse> getKoiByKeyword(String keyword, Pageable pageable) {
        return koiRepository.findByKeyword(keyword, pageable);
    }

    @Override
    public BidMethodQuantityResponse findQuantityByBidMethod() {
        List<AuctionKoi> auctionKois = auctionKoiRepository.findAll();
        long ascendingBid = auctionKois.stream()
            .filter(auctionKoi -> auctionKoi.getBidMethod() == EBidMethod.ASCENDING_BID).count();
        long descendingBid = auctionKois.stream()
            .filter(auctionKoi -> auctionKoi.getBidMethod() == EBidMethod.DESCENDING_BID).count();
        long fixedPrice = auctionKois.stream()
            .filter(auctionKoi -> auctionKoi.getBidMethod() == EBidMethod.FIXED_PRICE).count();

        return new BidMethodQuantityResponse(auctionKois.size(), ascendingBid, descendingBid, fixedPrice);
    }

    @Override
    public boolean findKoiInAuction(long koiId) {
        for (AuctionKoi auctionKoi : auctionKoiRepository.findAll()) {
            if (auctionKoi.getKoi().getId() == koiId) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void revokeKoiInAuction(long koiId) {

        auctionKoiRepository.findAll().stream()
            .filter(auctionKoi -> auctionKoi.getKoi().getId() == koiId)
            .findAny();


        for (AuctionKoi auctionKoi : auctionKoiRepository.findAll()) {
            if (auctionKoi.getKoi().getId() == koiId) {
                auctionKoi.setRevoked(1);
                auctionKoiRepository.save(auctionKoi);
            }
        }
    }

    @Override
    public List<AuctionKoiPort.AuctionKoiResponse> getAuctionKoiByAuctionId(long id) {
        return auctionKoiRepository.findAuctionKoiByAuctionId(id).stream()
            .map(DTOConverter::toAuctionKoiResponse)
            .toList();
    }

    @Override
    public Page<AuctionKoiPort.AuctionKoiResponse> getAllAuctionKois(Pageable pageable) {
        Page<AuctionKoi> kois = auctionKoiRepository.findAll(pageable);
        return kois.map(DTOConverter::toAuctionKoiResponse);
    }

    @Override
    public AuctionKoiPort.AuctionKoiResponse updateAuctionKoi(long auctionKoiId,
                                                              UpdateAuctionKoiDTO updateAuctionKoiDTO) {
        // find auctionKoi
        AuctionKoi updateAuctionKoi = auctionKoiRepository.findById(auctionKoiId)
            .orElseThrow(() -> new DataNotFoundException("auctionKoi not found: " + auctionKoiId));

        if (updateAuctionKoi.getBidMethod() == EBidMethod.DESCENDING_BID) {
            if (updateAuctionKoi.getCeilPrice() == null) {
                throw new MalformDataException("Ceil price is required for DESCENDING_BID");
            }
            if (updateAuctionKoi.getCurrentBid() > updateAuctionKoi.getCeilPrice()) {
                throw new MalformDataException("Current bid must be less than ceil price");
            }
            if (updateAuctionKoi.getCurrentBid() < updateAuctionKoi.getBasePrice()) {
                throw new MalformDataException("Current bid must be greater than base price");
            }
        }

        updateAuctionKoi.setBasePrice(updateAuctionKoiDTO.basePrice());
        updateAuctionKoi.setBidStep(updateAuctionKoiDTO.bidStep());
        updateAuctionKoi.setBidMethod(EBidMethod.valueOf(updateAuctionKoiDTO.bidMethod()));
        updateAuctionKoi.setCeilPrice(updateAuctionKoiDTO.ceilPrice());
        updateAuctionKoi.setCurrentBid(updateAuctionKoiDTO.currentBid());
        updateAuctionKoi.setCurrentBidderId(updateAuctionKoiDTO.currentBidderId());
        updateAuctionKoi.setRevoked(updateAuctionKoiDTO.revoked());
        updateAuctionKoi.setSold(updateAuctionKoiDTO.isSold());

        return DTOConverter.toAuctionKoiResponse(auctionKoiRepository.save(updateAuctionKoi));
    }

    @Override
    public void deleteAuctionKoi(long id) {
        auctionKoiRepository.findById(id)
            .orElseThrow(() -> new DataNotFoundException("Auction Koi not found"));
        auctionKoiRepository.softDeleteById(id);
    }

    @Override
    public AuctionKoiPort.AuctionKoiResponse getAuctionKoiDetailsById(long id) throws DataNotFoundException {
        AuctionKoi auctionKoi = auctionKoiRepository.findById(id)
            .orElseThrow(() -> new DataNotFoundException("Auction Koi not found"));
        return DTOConverter.toAuctionKoiResponse(auctionKoi);
    }

    @Override
    public AuctionKoiPort.AuctionKoiResponse getAuctionKoiByAuctionIdAndKoiId(long aid, long id)
        throws DataNotFoundException {
        List<AuctionKoi> auctionKois = auctionKoiRepository.findAuctionKoiByAuctionId(aid);
        AuctionKoi auctionKoi = auctionKois.stream()
            .filter(auctionKoi1 -> auctionKoi1.getId() == id).findFirst()
            .orElseThrow(() -> new DataNotFoundException("Auction Koi not found"));
        return DTOConverter.toAuctionKoiResponse(auctionKoi);
    }

    @Override
    @Transactional
    public boolean updateAuctionKoiStatus(long auctionKoiId, AuctionKoi auctionKoi) {
        AuctionKoi auctionKoiToUpdate = auctionKoiRepository.findById(auctionKoiId)
            .orElseThrow(() -> new DataNotFoundException("Auction Koi not found"));

        if (auctionKoiToUpdate.getAuction().getStatus().equals(EAuctionStatus.ENDED)) {
            if (auctionKoiToUpdate.isSold()) {
                return false;
            }

            // Handle force-ended auctions
            if (auctionKoiToUpdate.getCurrentBidderId() != 0) {
                // There's a valid bidder, mark as sold regardless of bid amount
                auctionKoiToUpdate.setSold(true);
                auctionKoiRepository.save(auctionKoiToUpdate);
                return true;
            } else if (auctionKoiToUpdate.getCurrentBid() > 0) {
                // Has bids but no current bidder (edge case)
            }
        }
        return false;
    }

    //AuctionParticipant
    @Override
    public AuctionParticipant createAuctionParticipant(AuctionParticipant auctionParticipant) {
        return auctionParticipantRepository.save(auctionParticipant);
    }

    @Override
    public AuctionParticipant getAuctionParticipantById(long id) {
        return auctionParticipantRepository.findById(id).orElse(null);
    }

    @Override
    public AuctionParticipant updateAuctionParticipant(long id, AuctionParticipant auctionParticipant) {
        return auctionParticipantRepository.save(auctionParticipant);
    }

    @Override
    public void deleteAuctionParticipant(long id) {
        auctionParticipantRepository.deleteById(id);
    }

    @Override
    public Boolean hasJoinedAuction(long auctionId, long userId) {
        try {
            return auctionParticipantRepository.getAuctionParticipantByAuctionIdAndUserId(auctionId, userId) != null;
        } catch (Exception e) {
            System.out.println("loi vcl: "+e.getMessage());
            return false;
        }
    }

    @Override
    public Set<UserResponse> getAllUserJoinAuction(long auctionId) throws DataNotFoundException {

        Optional<Auction> existingAuction = auctionRepository.findById(auctionId);

        if (existingAuction.isEmpty()) {
            throw new DataNotFoundException("Auction not found");
        }

        return auctionParticipantRepository.getAuctionParticipantsByAuctionId(auctionId)
            .stream()
            .map(AuctionParticipant::getUser)
            .map(DTOConverter::toUserResponse)
            .collect(java.util.stream.Collectors.toSet());
    }

}
