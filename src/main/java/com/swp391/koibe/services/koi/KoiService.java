package com.swp391.koibe.services.koi;

import com.swp391.koibe.dtos.KoiDTO;
import com.swp391.koibe.exceptions.DataNotFoundException;
import com.swp391.koibe.models.Category;
import com.swp391.koibe.models.Koi;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.CategoryRepository;
import com.swp391.koibe.repositories.KoiRepository;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.responses.KoiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KoiService implements IKoiService {

    private final KoiRepository koiRepository;
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;

    @Override
    public Koi createKoi(KoiDTO koiDTO) throws DataNotFoundException {

        User existedUser = userRepository.findById(koiDTO.getOwnerId())
            .orElseThrow(() ->
                             new DataNotFoundException("User not found: " + koiDTO.getOwnerId()));

        Category existedCategory = categoryRepository.findById(koiDTO.getCategoryId())
            .orElseThrow(() ->
                             new DataNotFoundException("Category not found: " + koiDTO.getCategoryId()));

        Koi newKoi = Koi.builder()
            .name(koiDTO.getName())
            .price(koiDTO.getPrice())
//            .trackingStatus(koiDTO.getKoiTrackingStatus())
            .isDisplay(koiDTO.getIsDisplay())
            .thumbnail(koiDTO.getThumbnail())
            .sex(koiDTO.getSex())
            .length(koiDTO.getLength())
            .age(koiDTO.getAge())
            .description(koiDTO.getDescription())
            .owner(existedUser)
            .category(existedCategory)
            .build();
        return koiRepository.save(newKoi);
    }

    @Override
    public Koi getKoiById(long id) {
        return null;
    }

    @Override
    public Page<KoiResponse> getAllKois(Pageable pageable) {
        Page<Koi> kois = koiRepository.findAll(pageable);
        return kois.map(KoiResponse::convertToDTO);
    }

    @Override
    public Koi updateKoi(long id, KoiDTO koiDTO) {
        return null;
    }

    @Override
    public void deleteKoi(long id) {

    }

    @Override
    public boolean existsByName(String name) {
        return koiRepository.existsByName(name);
    }
}
