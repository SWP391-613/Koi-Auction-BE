package com.swp391.koibe.domain.user.breeder;

import com.swp391.koibe.api.PageResponse;
import com.swp391.koibe.domain.koi.KoiPort;
import com.swp391.koibe.domain.mail.KoiDTO;
import com.swp391.koibe.domain.user.BreederResponse;
import com.swp391.koibe.domain.user.User;
import com.swp391.koibe.domain.user.UserResponse;
import com.swp391.koibe.enums.EKoiStatus;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IBreederService {

    PageResponse<BreederResponse> getAllBreeders(Pageable pageable);
    List<UserResponse> getAllBreeders();
    User findById(long breederId) throws DataNotFoundException;
    KoiPort.KoiResponse createKoi(Long categoryId, KoiDTO koiDTO, long breederId);
    void updateBreeder(long breederId, User breeder);
    void updateKoi(long koiId, KoiDTO koiDTO);
    void deleteBreeder(long breederId);
    void deleteKoi(long koiId, long breederId);
    List<KoiPort.KoiResponse> getKoisByBreederID(long breederId);
    Page<KoiPort.KoiResponse> getKoisByBreederID(long breederId, Pageable pageable);
    Page<KoiPort.KoiResponse> getKoisByBreederIdAndStatus(long breederId, EKoiStatus koiStatus, Pageable pageable);
    Page<KoiPort.KoiResponse> getKoisByBreederIdNotInAnyAuction(long breederId, Pageable pageable);

}
