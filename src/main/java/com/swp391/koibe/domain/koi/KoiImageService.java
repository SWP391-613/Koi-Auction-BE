package com.swp391.koibe.domain.koi;

import com.swp391.koibe.metadata.MediaMeta;
import com.swp391.koibe.repositories.KoiImageRepository;
import com.swp391.koibe.utils.DTOConverter;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KoiImageService implements IKoiImageService {

    private final KoiImageRepository koiImageRepository;
    private final IKoiService koiService;

    @Override
    public void createKoiImage(long koiId, String url) throws Exception {
        Koi koi = (Koi) koiService.getKoiById(koiId).blockingGet();
        koi.setId(koiId);
        KoiImage koiImage = KoiImage.builder()
            .koi(koi)
            .mediaMeta(MediaMeta.builder().imageUrl(url).build())
            .build();
        koiImageRepository.save(koiImage);
    }

    @Override
    public void updateKoiImage(long id, long koiId, String url) throws Exception {
        KoiImage koiImage = koiImageRepository.findById(id)
            .orElseThrow(() -> new Exception("Koi image not found"));
        koiImage.setMediaMeta(MediaMeta.builder().imageUrl(url).build());
        koiImageRepository.save(koiImage);
    }

    @Override
    public void deleteKoiImage(long id) throws Exception {
        KoiImage koiImage = koiImageRepository.findById(id)
            .orElseThrow(() -> new Exception("Koi image not found"));
        koiImageRepository.delete(koiImage);
    }

    @Override
    public List<KoiPort.KoiImageResponse> getKoiImage(long id) throws Exception {
        koiImageRepository.findById(id)
            .orElseThrow(() -> new Exception("Koi image not found"));
        return List.of(DTOConverter.toKoiImageResponse(koiImageRepository.getById(id)));
    }

    @Override
    public Page<KoiPort.KoiImageResponse> getAllKoiImages(Pageable pageable) throws Exception {
        Page<KoiImage> koiImages = koiImageRepository.findAll(pageable);
        return koiImages.map(DTOConverter::toKoiImageResponse);
    }

    @Override
    public List<KoiPort.KoiImageResponse> getKoiImagesByKoiId(Long koiId) throws Exception {
        List<KoiImage> koiImages = koiImageRepository.findByKoiId(koiId);
            if (koiImages.isEmpty()) {
                throw new Exception("Koi images not found");
            }
        return koiImages.stream().map(DTOConverter::toKoiImageResponse).toList();

    }


}
