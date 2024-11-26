package com.swp391.koibe.services.koi;

import com.swp391.koibe.dtos.KoiImageDTO;
import com.swp391.koibe.dtos.koi.KoiDTO;
import com.swp391.koibe.dtos.koi.UpdateKoiDTO;
import com.swp391.koibe.dtos.koi.UpdateKoiStatusDTO;
import com.swp391.koibe.enums.EKoiGender;
import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.exceptions.InvalidParamException;
import com.swp391.koibe.exceptions.MalformBehaviourException;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.Category;
import com.swp391.koibe.models.Koi;
import com.swp391.koibe.models.KoiImage;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.CategoryRepository;
import com.swp391.koibe.repositories.KoiImageRepository;
import com.swp391.koibe.repositories.KoiRepository;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.responses.KoiGenderResponse;
import com.swp391.koibe.responses.KoiResponse;
import com.swp391.koibe.responses.KoiStatusResponse;
import com.swp391.koibe.services.auctionkoi.AuctionKoiService;
import com.swp391.koibe.services.mail.IMailService;
import com.swp391.koibe.utils.DTOConverter;
import io.reactivex.rxjava3.core.Single;
import io.reactivex.rxjava3.schedulers.Schedulers;
import jakarta.mail.MessagingException;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thymeleaf.context.Context;

@Service
@RequiredArgsConstructor
public non-sealed class KoiService implements IKoiService<KoiResponse> {

    private final KoiRepository koiRepository;
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;
    private final KoiImageRepository koiImageRepository;
    private final IMailService mailService;
    private final AuctionKoiService auctionKoiService;

    @Override
    public Single<Koi> createKoi(KoiDTO koiDTO, long breederId) throws Exception {
        //breeder cannot create other breeder's koi
        if(breederId != koiDTO.ownerId()){
            throw new InvalidParamException("Breeder cannot create other breeder's koi");
        }

        //breeder create their own koi
        Single<User> existedUser = Single.fromCallable(() ->
           userRepository.findBreederById(koiDTO.ownerId())
               .orElseThrow(() -> new DataNotFoundException("Breeder not found: " + koiDTO.ownerId()))
        ).subscribeOn(Schedulers.io());

        Single<Category> existedCategory = Single.fromCallable(() ->
           categoryRepository.findById(koiDTO.categoryId())
               .orElseThrow(() -> new DataNotFoundException("Category not found: " + koiDTO.categoryId()))
        ).subscribeOn(Schedulers.io());

        return Single.zip(
            existedUser, existedCategory, (user, category) -> {

                Koi newKoi = Koi.builder()
                    .name(koiDTO.name())
                    .price(koiDTO.price())
                    .status(EKoiStatus.UNVERIFIED) //default when create a new koi, breeder need to wait staff verify
                    .isDisplay(1) //default when create a new koi, breeder need to wait staff verify then turn to 1
                    .thumbnail(koiDTO.thumbnail())
                    .sex(EKoiGender.valueOf(koiDTO.sex()))
                    .length(koiDTO.length())
                    .yearBorn(koiDTO.yearBorn())
                    .description(koiDTO.description() == null ? "Not provided" : koiDTO.description())
                    .owner(user)
                    .category(category)
                    .build();

                return koiRepository.save(newKoi);
            }).subscribeOn(Schedulers.io());
    }

    @Override
    public Single<KoiResponse> getKoiById(long id) throws DataNotFoundException {
        return Single.fromCallable(() -> {
            Koi koi = koiRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Koi not found: " + id));
            return DTOConverter.convertToKoiDTO(koi);
        }).subscribeOn(Schedulers.io());
    }

    @Override
    public Page<KoiResponse> getAllKois(Pageable pageable) {
        Page<Koi> kois = koiRepository.findAllKoiByIsDisplayIsTrue(pageable);
        return kois.map(DTOConverter::convertToKoiDTO);
    }

    @Override
    public KoiResponse updateKoi(long id, UpdateKoiDTO koiDTO) {
        //find if koi exist
        Koi existingKoi = koiRepository.findById(id)
            .orElseThrow(() -> new DataNotFoundException("Koi not found: " + id));

        if(existingKoi.getIsDisplay() == 0)
            throw new MalformBehaviourException("Koi already deleted");

        if(existingKoi.getStatus() == EKoiStatus.VERIFIED || existingKoi.getStatus() == EKoiStatus.SOLD){
            throw new MalformBehaviourException("Cannot update koi already verified or sold");
        }

        //find if koi owner exist
        User existingUser = userRepository.findById(koiDTO.ownerId())
            .orElseThrow(() -> new DataNotFoundException("User not found: " + koiDTO.ownerId()));

        // find if koi category exist
        Category existingCategory = categoryRepository.findById(koiDTO.categoryId())
            .orElseThrow(() -> new DataNotFoundException("Category not found: " + koiDTO.categoryId()));

        existingKoi.setName(koiDTO.name());
        existingKoi.setStatus(EKoiStatus.valueOf(koiDTO.trackingStatus()));
        existingKoi.setIsDisplay(koiDTO.isDisplay());
        existingKoi.setThumbnail(koiDTO.thumbnail());
        existingKoi.setSex(EKoiGender.valueOf(koiDTO.sex()));
        existingKoi.setLength(koiDTO.length());
        existingKoi.setYearBorn(koiDTO.yearBorn());
        existingKoi.setDescription(koiDTO.description());
        existingKoi.setCategory(existingCategory);
        existingKoi.setOwner(existingUser);

        return DTOConverter.convertToKoiDTO(koiRepository.save(existingKoi));
    }

    @Override
    @Transactional
    public void deleteKoi(long id) throws Exception {
        //find if koi exist
        Koi existingKoi = koiRepository.findById(id)
            .orElseThrow(() -> new DataNotFoundException("Koi not found: " + id));

        if(existingKoi.getIsDisplay() == 0)
            throw new MalformBehaviourException("Koi already deleted");

        if(auctionKoiService.findKoiInAuction(id))
            throw new MalformBehaviourException("Cannot delete koi already register in auction");
        koiRepository.softDeleteKoi(id);
    }

    @Override
    public KoiImage createKoiImage(Long koiId, KoiImageDTO koiImageDTO) throws Exception {
        Koi existingKoi = koiRepository
            .findById(koiId)
            .orElseThrow(() ->
                             new DataNotFoundException("Category not found: " + koiImageDTO.koiId()));

        KoiImage newKoiImage = KoiImage.builder()
            .koi(existingKoi)
            .imageUrl(koiImageDTO.imageUrl())
            .build();
        //khong cho insert qua 5 anh cho mot san pham
        int size = koiImageRepository.findByKoiId(koiId).size();
        if (size >= KoiImage.MAXIMUM_IMAGES_PER_PRODUCT) {
            throw new InvalidParamException(
                "Maximum images per product: "
                    + KoiImage.MAXIMUM_IMAGES_PER_PRODUCT);
        }
        return koiImageRepository.save(newKoiImage);
    }

    @Override
    public Page<KoiResponse> getKoiByStatus(Pageable pageable, EKoiStatus status) {
        return koiRepository
            .findByStatus(status, pageable)
            .map(DTOConverter::convertToKoiDTO);
    }

    @Override
    public Page<KoiResponse> getBreederKoiByStatus(Pageable pageable, long breederId,
                                                   EKoiStatus status) {
        return null;
    }

    @Override
    public Single<Void> updateKoiStatus(long id, UpdateKoiStatusDTO updateKoiStatusDTO) {
        EKoiStatus eKoiStatus = EKoiStatus.valueOf(updateKoiStatusDTO.trackingStatus());
        return Single.fromCallable(() -> {
            Koi existingKoi = koiRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Koi not found: " + id));

            existingKoi.setStatus(eKoiStatus);
            koiRepository.save(existingKoi);
            return existingKoi;
        }).flatMap(existingKoi -> {
            User owner = existingKoi.getOwner();
            Context context = new Context();
            context.setVariable("name", owner.getFirstName());
            context.setVariable("koiName", existingKoi.getName());
            context.setVariable("status", existingKoi.getStatus());

            String templateName = eKoiStatus == EKoiStatus.VERIFIED ? "koiApproved" : "koiRejected";

            return Single.fromCallable(() -> {
                mailService.sendMail(owner.getEmail(), "Your koi status", templateName, context);
                return null; // return null or whatever result type you expect
            });
        });
    }

    @Override
    public Page<Koi> findKoiByKeyword(String keyword, long breederId, Pageable pageable) {
        return koiRepository.findKoiByKeyword(keyword, breederId,  pageable);
    }

    @Override
    public Page<Koi> findUnverifiedKoiByKeyword(String keyword, Pageable pageable) {
        return koiRepository.findUnverifiedKoiByKeyword(keyword,  pageable);
    }

    @Override
    public Page<Koi> findAllKoiByKeyword(String keyword, Pageable pageable) {
        return koiRepository.findAllKoiByKeyword(keyword,  pageable);
    }

    @Override
    public KoiGenderResponse findQuantityKoiByGender() {
        List<Koi> kois = koiRepository.findAll().stream().filter(koi -> koi.getIsDisplay() == 1).toList();

        long maleCount = kois.stream()
            .filter(koi -> koi.getSex() == EKoiGender.MALE)
            .count();

        long femaleCount = kois.stream()
            .filter(koi -> koi.getSex() == EKoiGender.FEMALE)
            .count();

        long unknownCount = kois.stream()
            .filter(koi -> koi.getSex() == EKoiGender.UNKNOWN)
            .count();

        return KoiGenderResponse.builder()
            .total(kois.size())
            .male(maleCount)
            .female(femaleCount)
            .unknown(unknownCount)
            .build();
    }

    @Override
    public KoiStatusResponse findQuantityKoiByStatus() {
        List<Koi> kois = koiRepository.findAll().stream().filter(koi -> koi.getIsDisplay() == 1).toList();

        long unverifiedCount = kois.stream()
            .filter(koi -> koi.getStatus() == EKoiStatus.UNVERIFIED)
            .count();

        long verifiedCount = kois.stream()
            .filter(koi -> koi.getStatus() == EKoiStatus.VERIFIED)
            .count();

        long rejectedCount = kois.stream()
            .filter(koi -> koi.getStatus() == EKoiStatus.REJECTED)
            .count();

        long soldCount = kois.stream()
            .filter(koi -> koi.getStatus() == EKoiStatus.SOLD)
            .count();

        return KoiStatusResponse.builder()
            .total(kois.size())
            .unverified(unverifiedCount)
            .verified(verifiedCount)
            .rejected(rejectedCount)
            .sold(soldCount)
            .build();
    }


}
