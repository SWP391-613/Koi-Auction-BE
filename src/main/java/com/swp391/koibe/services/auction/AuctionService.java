package com.swp391.koibe.services.auction;

import com.swp391.koibe.dtos.AuctionDTO;
import com.swp391.koibe.dtos.UpdateAuctionDTO;
import com.swp391.koibe.enums.EAuctionStatus;
import com.swp391.koibe.exceptions.DeleteException;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.metadata.PaginationMeta;
import com.swp391.koibe.models.Auction;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.AuctionKoiRepository;
import com.swp391.koibe.repositories.AuctionParticipantRepository;
import com.swp391.koibe.repositories.AuctionRepository;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.responses.AuctionResponse;
import com.swp391.koibe.responses.AuctionStatusCountResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.utils.DTOConverter;
import com.swp391.koibe.utils.DateTimeUtils;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuctionService implements IAuctionService {

    private final AuctionRepository auctionRepository;
    private final AuctionParticipantRepository auctionParticipantRepository;
    private final AuctionKoiRepository auctionKoiRepository;
    private final UserRepository userRepository;

    @Override
    public AuctionResponse createAscendingAuction(AuctionDTO auctionDTO) throws DataAlreadyExistException {
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
    public AuctionResponse getById(long id) throws DataNotFoundException {
        return auctionRepository.findById(id)
            .map(DTOConverter::toAuctionResponse)
            .orElseThrow(() -> new DataNotFoundException("Auction not found"));
    }

    @Override
    public AuctionResponse findAuctionById(long id) throws DataNotFoundException {
        return auctionRepository.findById(id)
            .map(DTOConverter::toAuctionResponse)
            .orElseThrow(() -> new DataNotFoundException("Auction not found"));
    }

    @Override
    public PageResponse<AuctionResponse> getAllAuctions(Pageable pageable) {
        Page<Auction> auctions = auctionRepository.findAll(pageable);

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
    public Page<AuctionResponse> getAuctionByStatus(EAuctionStatus status, Pageable pageable) {
        Page<Auction> auctions = auctionRepository.findAll(pageable);
        List<AuctionResponse> filteredAuctions = auctions.stream()
            .filter(auction -> auction.getStatus() == status)
            .map(DTOConverter::toAuctionResponse)
            .collect(Collectors.toList());
        return new PageImpl<>(filteredAuctions, pageable, filteredAuctions.size());
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
    public PageResponse<AuctionResponse> getAuctionByKeyword(String keyword, Pageable pageable) {

        Page<Auction> auctions = auctionRepository.getAuctionByKeyword(keyword, pageable);

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
    public PageResponse<AuctionResponse> getAuctionUpcomingByKeyword(String keyword, EAuctionStatus status,
                                                     Pageable pageable) {
        Page<Auction> auctions = auctionRepository.getAuctionUpcomingByKeyword(keyword, status, pageable);

        List<AuctionResponse> auctionResponses = auctions.stream()
            .map(DTOConverter::toAuctionResponse)
            .toList();

        return PageResponse.<AuctionResponse>pageBuilder()
            .message("Get all upcoming auctions successfully")
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
}
