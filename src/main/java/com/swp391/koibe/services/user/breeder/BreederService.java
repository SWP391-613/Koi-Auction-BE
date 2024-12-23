package com.swp391.koibe.services.user.breeder;

import com.swp391.koibe.dtos.koi.KoiDTO;
import com.swp391.koibe.enums.EKoiGender;
import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.exceptions.BreederNotFoundException;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.metadata.PaginationMeta;
import com.swp391.koibe.models.Category;
import com.swp391.koibe.models.Koi;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.CategoryRepository;
import com.swp391.koibe.repositories.KoiRepository;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.responses.BreederResponse;
import com.swp391.koibe.responses.KoiResponse;
import com.swp391.koibe.responses.UserResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.utils.DTOConverter;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BreederService implements IBreederService {

    private final UserRepository userRepository;
    private final KoiRepository koiRepository;
    private final CategoryRepository categoryRepository;
    private final DTOConverter dtoConverter;

    @Override
    public PageResponse<BreederResponse> getAllBreeders(Pageable pageable) {
        Page<User> breeders = userRepository.findAllBreeder(pageable);
        List<BreederResponse> breederResponses = breeders.getContent()
            .stream()
            .map(dtoConverter::toBreederResponse)
            .toList();

        return PageResponse.<BreederResponse>pageBuilder()
            .message("Get all breeders successfully")
            .statusCode(200)
            .isSuccess(true)
            .data(breederResponses)
            .pagination(PaginationMeta.builder()
                            .totalPages(breeders.getTotalPages())
                            .totalItems(breeders.getTotalElements())
                            .currentPage(pageable.getPageNumber())
                            .pageSize(pageable.getPageSize())
                            .build())
            .build();
    }

    @Override
    public List<UserResponse> getAllBreeders() {
        return userRepository.findAll()
            .stream()
            .filter(breeder -> breeder.getRole().getId() == 3)
            .map(DTOConverter::toUserResponse)
            .toList();
    }

    private List<User> getAllBreedersList() {
        return userRepository.findAll()
            .stream()
            .filter(breeder -> breeder.getRole().getId() == 3)
            .toList();
    }

    @Override
    public User findById(long breederId) throws DataNotFoundException {
        return userRepository.findBreederById(breederId)
            .orElseThrow(() -> new BreederNotFoundException("Breeder not found"));
    }

    @Override
    public KoiResponse createKoi(Long categoryId, KoiDTO koiDTO, long breederId) {

        User existingBreeder = userRepository.findBreederById(koiDTO.ownerId())
            .orElseThrow(() ->
                             new BreederNotFoundException(
                                 "Breeder not found: " + koiDTO.ownerId()));

        Optional<Category> existingCategory = categoryRepository.findById(categoryId);
        if (existingCategory.isEmpty()) {
            throw new DataNotFoundException("Category not found");
        }

        if (koiDTO.ownerId() != breederId) {
            throw new MalformDataException("Owner id not match with current breederId");
        }

        if (!Objects.equals(koiDTO.categoryId(), categoryId)) {
            throw new MalformDataException("Category id not match");
        }

        Koi newKoi = Koi.builder()
            .name(koiDTO.name())
            .price(koiDTO.price())
            .status(EKoiStatus.UNVERIFIED)
            .isDisplay(0)
            .thumbnail(koiDTO.thumbnail())
            .sex(EKoiGender.valueOf(koiDTO.sex()))
            .length(koiDTO.length())
            .yearBorn(koiDTO.yearBorn())
            .description(koiDTO.description() == null ? "Not provided" : koiDTO.description())
            .category(existingCategory.get())
            .owner(existingBreeder)
            .build();

        return DTOConverter.toKoiResponse(koiRepository.save(newKoi));
    }

    @Override
    public void updateBreeder(long breederId, User breeder) {

    }

    @Override
    public void updateKoi(long koiId, KoiDTO koiDTO) {

    }

    @Override
    public void deleteBreeder(long breederId) {
        if (userRepository.findById(breederId).isEmpty()
            && userRepository.findById(breederId).get().getRole().getId() != 3) {
            throw new BreederNotFoundException("Breeder not found");
        }

        userRepository.deleteById(breederId);
    }

    @Override
    public void deleteKoi(long koiId, long breederId) {
        if (userRepository.findById(breederId).isEmpty()
            && userRepository.findById(breederId).get().getRole().getId() != 3) {
            throw new BreederNotFoundException("Breeder not found");
        }

        if (koiRepository.findById(koiId).isEmpty()) {
            throw new DataNotFoundException("Koi not found");
        }

        if (koiRepository.findById(koiId).get().getOwner().getId() != breederId) {
            throw new MalformDataException("Koi not belong to breeder");
        }

        koiRepository.deleteById(koiId);
    }

    @Override
    public List<KoiResponse> getKoisByBreederID(long breederId) {
        findById(breederId);

        return koiRepository
            .findAll()
            .stream()
            .filter(koi -> koi.getOwner().getId() == breederId)
            .map(DTOConverter::toKoiResponse).toList();
    }

    @Override
    public Page<KoiResponse> getKoisByBreederID(long breederId, Pageable pageable) {
        findById(breederId);

        return koiRepository
            .findByOwnerId(breederId, pageable)
            .map(DTOConverter::toKoiResponse);
    }

    @Override
    public Page<KoiResponse> getKoisByBreederIdAndStatus(long breederId, EKoiStatus koiStatus,
                                                         Pageable pageable) {
        findById(breederId);

        return koiRepository
            .findByOwnerIdAndStatus(breederId, koiStatus, pageable)
            .map(DTOConverter::toKoiResponse);
    }

    @Override
    public Page<KoiResponse> getKoisByBreederIdNotInAnyAuction(long breederId, Pageable pageable) {
        userRepository.findBreederById(breederId)
            .orElseThrow(() -> new BreederNotFoundException("Breeder not found"));

        return koiRepository
            .findByOwnerIdAndStatusAndAuctionIsNull(breederId, pageable)
            .map(DTOConverter::toKoiResponse);

    }

    /*
    *  @Override
    public Page<AuctionResponse> getAuctionByStatus(EAuctionStatus status, Pageable pageable) {
        Page<Auction> auctions = auctionRepository.findAll(pageable);
        List<AuctionResponse> filteredAuctions = auctions.stream()
            .filter(auction -> auction.getStatus() == status)
            .map(DTOConverter::convertToAuctionDTO)
            .collect(Collectors.toList());
        return new PageImpl<>(filteredAuctions, pageable, filteredAuctions.size());
    }*/

}
