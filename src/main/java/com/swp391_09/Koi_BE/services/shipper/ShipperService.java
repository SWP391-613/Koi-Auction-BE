package com.swp391_09.Koi_BE.services.shipper;

import com.swp391_09.Koi_BE.repositories.ShipperRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ShipperService implements IShipperService{

    private final ShipperRepository shipperRepository;

    @Override
    public void createShipper(String companyName, String phoneNumber) throws Exception {

    }

    @Override
    public void updateShipper(int id, String companyName, String phoneNumber) throws Exception {

    }

    @Override
    public void deleteShipper(int id) throws Exception {

    }

    @Override
    public void getShipper(int id) throws Exception {

    }

    @Override
    public void getShippers() throws Exception {

    }

    @Override
    public void getShipperByCompanyName(String companyName) throws Exception {

    }

    @Override
    public void getShipperByPhoneNumber(String phoneNumber) throws Exception {

    }
}
