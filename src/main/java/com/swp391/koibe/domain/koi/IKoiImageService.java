package com.swp391.koibe.domain.koi;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IKoiImageService {

    void createKoiImage(long koiId, String url) throws Exception;

    void updateKoiImage(long id, long koiId, String url) throws Exception;

    void deleteKoiImage(long id) throws Exception;

    List<KoiPort.KoiImageResponse> getKoiImage(long id) throws Exception;

    Page<KoiPort.KoiImageResponse> getAllKoiImages(Pageable pageable) throws Exception;
    List<KoiPort.KoiImageResponse> getKoiImagesByKoiId(Long koiId) throws Exception;

}
