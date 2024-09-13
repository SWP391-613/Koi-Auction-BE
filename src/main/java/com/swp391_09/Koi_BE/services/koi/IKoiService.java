package com.swp391_09.Koi_BE.services.koi;

import com.swp391_09.Koi_BE.dtos.KoiDTO;
import com.swp391_09.Koi_BE.models.Koi;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IKoiService {

    Koi createKoi(KoiDTO category);
    Koi getKoiById(long id);
    Page<Koi> getAllKois(Pageable pageable);
    Koi updateKoi(long categoryId, KoiDTO category);
    void deleteKoi(long id);
    boolean existsByName(String name);

}
