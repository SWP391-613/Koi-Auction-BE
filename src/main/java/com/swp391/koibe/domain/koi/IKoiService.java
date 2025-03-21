package com.swp391.koibe.domain.koi;

import com.swp391.koibe.dtos.KoiImageDTO;
import com.swp391.koibe.dtos.koi.KoiDTO;
import com.swp391.koibe.dtos.koi.UpdateKoiDTO;
import com.swp391.koibe.dtos.koi.UpdateKoiStatusDTO;
import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.dtos.responses.KoiGenderResponse;
import com.swp391.koibe.dtos.responses.KoiResponse;
import com.swp391.koibe.dtos.responses.KoiStatusResponse;
import com.swp391.koibe.api.PageResponse;
import io.reactivex.rxjava3.core.Single;
import org.springframework.data.domain.Pageable;

public sealed interface IKoiService<T> permits KoiService {

    Single<KoiResponse> createKoi(KoiDTO koiDTO, long breederId) throws Exception;

    Single<KoiResponse> getKoiById(long id) throws DataNotFoundException;

    PageResponse<KoiResponse> getAllKois(Pageable pageable);

    KoiResponse updateKoi(long id, UpdateKoiDTO koiDTO);

    void deleteKoi(long id) throws Exception;

    KoiImage createKoiImage(Long koiId, KoiImageDTO koiImageDTO) throws Exception;

    PageResponse<KoiResponse> getKoiByStatus(Pageable pageable,EKoiStatus status);

    PageResponse<KoiResponse> getBreederKoiByStatus(Pageable pageable, long breederId,EKoiStatus status);

    void updateKoiStatus(long id, UpdateKoiStatusDTO updateKoiStatusDTO);

    PageResponse<KoiResponse> findKoiByKeyword(String keyword, long breederId, Pageable pageable);

    PageResponse<KoiResponse> findUnverifiedKoiByKeyword(String keyword, Pageable pageable);

    PageResponse<KoiResponse> findAllKoiByKeyword(String keyword, Pageable pageable);

    KoiGenderResponse findQuantityKoiByGender();

    KoiStatusResponse findQuantityKoiByStatus();

}