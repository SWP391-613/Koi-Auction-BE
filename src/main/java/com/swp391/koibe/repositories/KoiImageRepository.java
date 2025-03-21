package com.swp391.koibe.repositories;

import com.swp391.koibe.domain.koi.KoiImage;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface KoiImageRepository extends JpaRepository<KoiImage, Long> {

    List<KoiImage> findByKoiId(Long koiId);

}
