package com.swp391_09.Koi_BE.services.koi;

import com.swp391_09.Koi_BE.dtos.KoiDTO;
import com.swp391_09.Koi_BE.exceptions.DataNotFoundException;
import com.swp391_09.Koi_BE.models.Koi;
import com.swp391_09.Koi_BE.responses.KoiResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IKoiService {

    Koi createKoi(KoiDTO koiDTO) throws DataNotFoundException;
    Koi getKoiById(long id);
    Page<KoiResponse> getAllKois(Pageable pageable);
    Koi updateKoi(long id, KoiDTO koiDTO);
    void deleteKoi(long id);
    boolean existsByName(String name);

}
