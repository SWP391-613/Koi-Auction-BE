package com.swp391.koibe.services.user.breeder;

import com.swp391.koibe.exceptions.notfound.DataNotFoundException;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.UserResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IBreederService {

    Page<UserResponse> getAllBreeders(Pageable pageable);
    User findById(long breederId) throws DataNotFoundException;
    User create(User breeder);
    User update(long breederId, User breeder);
    void delete(long id);

}