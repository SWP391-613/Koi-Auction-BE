package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.Shipper;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ShipperRepository extends JpaRepository<Shipper, Integer> {
    Shipper findByCompanyName(String companyName);
    Shipper findByPhoneNumber(String phoneNumber);
}
