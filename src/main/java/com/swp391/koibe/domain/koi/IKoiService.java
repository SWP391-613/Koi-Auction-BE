package com.swp391.koibe.domain.koi;

import com.swp391.koibe.api.PageResponse;
import com.swp391.koibe.domain.mail.KoiDTO;
import com.swp391.koibe.domain.mail.UpdateKoiDTO;
import com.swp391.koibe.domain.mail.UpdateKoiStatusDTO;
import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.metadata.MediaMeta;
import io.reactivex.rxjava3.core.Single;
import org.springframework.data.domain.Pageable;

public sealed interface IKoiService<T> permits KoiService {

    Single<KoiPort.KoiResponse> createKoi(KoiDTO koiDTO, long breederId) throws Exception;

    Single<KoiPort.KoiResponse> getKoiById(long id) throws DataNotFoundException;

    KoiPort.KoiResponse updateKoi(long id, UpdateKoiDTO koiDTO);

    void deleteKoi(long id) throws Exception;

    KoiImage createKoiImage(Long koiId, MediaMeta mediaMeta, KoiPort.KoiImageDTO koiImageDTO) throws Exception;

    PageResponse<KoiPort.KoiResponse> getKoiByStatus(Pageable pageable,EKoiStatus status);

    void updateKoiStatus(long id, UpdateKoiStatusDTO updateKoiStatusDTO);

    PageResponse<KoiPort.KoiResponse> findKoiByKeyword(String keyword, long breederId, Pageable pageable);

    PageResponse<KoiPort.KoiResponse> findUnverifiedKoiByKeyword(String keyword, Pageable pageable);

    PageResponse<KoiPort.KoiResponse> findAllKoiByKeyword(String keyword, Pageable pageable);

    KoiPort.KoiGenderResponse findQuantityKoiByGender();

    KoiPort.KoiStatusResponse findQuantityKoiByStatus();

}