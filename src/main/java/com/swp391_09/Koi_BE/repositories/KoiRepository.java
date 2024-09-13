package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.Koi;
import org.springframework.data.jpa.repository.JpaRepository;

public interface KoiRepository extends JpaRepository<Koi, Long> {
    boolean existsByName(String name);
}
