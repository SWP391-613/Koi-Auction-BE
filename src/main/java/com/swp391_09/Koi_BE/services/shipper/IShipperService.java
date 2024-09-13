package com.swp391_09.Koi_BE.services.shipper;

public interface IShipperService {
    void createShipper(String companyName, String phoneNumber) throws Exception;
    void updateShipper(int id, String companyName, String phoneNumber) throws Exception;
    void deleteShipper(int id) throws Exception;
    void getShipper(int id) throws Exception;
    void getShippers() throws Exception;
    void getShipperByCompanyName(String companyName) throws Exception;
    void getShipperByPhoneNumber(String phoneNumber) throws Exception;
}
