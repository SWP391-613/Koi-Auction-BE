package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.KoiImage;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface KoiImageRepository extends JpaRepository<KoiImage, Long> {
    List<KoiImage> findByKoiId(Long koiId);
}
