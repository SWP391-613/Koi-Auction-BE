package com.swp391_09.Koi_BE.services.koi;

import com.swp391_09.Koi_BE.dtos.KoiDTO;
import com.swp391_09.Koi_BE.models.Koi;
import com.swp391_09.Koi_BE.repositories.KoiRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KoiService implements IKoiService {

    private final KoiRepository koiRepository;

    @Override
    public Koi createKoi(KoiDTO category) {
        return null;
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
    public Koi updateKoi(long categoryId, KoiDTO category) {
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
