package com.swp391_09.Koi_BE.services.koiimage;

public interface IKoiImageService {

    void createKoiImage(int koiId, String url) throws Exception;

    void updateKoiImage(int id, int koiId, String url) throws Exception;

    void deleteKoiImage(int id) throws Exception;

    void getKoiImage(int id) throws Exception;

    void getKoiImages() throws Exception;

}
