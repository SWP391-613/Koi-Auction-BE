package com.swp391_09.Koi_BE.services.koiimage;

import com.swp391_09.Koi_BE.repositories.KoiImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KoiImageService implements IKoiImageService {

    private final KoiImageRepository koiImageRepository;

    @Override
    public void createKoiImage(int koiId, String url) throws Exception {

    }

    @Override
    public void updateKoiImage(int id, int koiId, String url) throws Exception {

    }

    @Override
    public void deleteKoiImage(int id) throws Exception {

    }

    @Override
    public void getKoiImage(int id) throws Exception {

    }

    @Override
    public void getKoiImages() throws Exception {

    }
}
