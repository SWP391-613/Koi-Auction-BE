package com.swp391_09.Koi_BE.services.koi;

import com.swp391_09.Koi_BE.dtos.KoiDTO;
import com.swp391_09.Koi_BE.exceptions.DataNotFoundException;
import com.swp391_09.Koi_BE.models.Category;
import com.swp391_09.Koi_BE.models.Koi;
import com.swp391_09.Koi_BE.models.User;
import com.swp391_09.Koi_BE.repositories.CategoryRepository;
import com.swp391_09.Koi_BE.repositories.KoiRepository;
import com.swp391_09.Koi_BE.repositories.UserRepository;
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

        User existedUser = userRepository.findById(koiDTO.getUserId())
            .orElseThrow(() ->
                             new DataNotFoundException("User not found: " + koiDTO.getUserId()));

        Category existedCategory = categoryRepository.findById(koiDTO.getCategoryId())
            .orElseThrow(() ->
                             new DataNotFoundException("Category not found: " + koiDTO.getCategoryId()));

        Koi newKoi = Koi.builder()
            .name(koiDTO.getName())
            .price(koiDTO.getPrice())
            .trackingStatus(koiDTO.getTrackingStatus())
            .isDisplay(koiDTO.getIsDisplay())
            .isSold(koiDTO.getIsSold())
            .thumbnail(koiDTO.getThumbnail())
            .sex(koiDTO.getSex())
            .length(koiDTO.getLength())
            .age(koiDTO.getAge())
            .description(koiDTO.getDescription())
            .user(existedUser)
            .category(existedCategory)
            .build();
        return koiRepository.save(newKoi);
    }

    @Override
    public Koi getKoiById(long id) {
        return null;
    }

    @Override
    public Page<Koi> getAllKois(Pageable pageable) {
        return koiRepository.findAll(pageable);
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
