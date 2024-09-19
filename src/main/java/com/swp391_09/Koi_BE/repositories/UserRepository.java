package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.User;
import com.swp391_09.Koi_BE.responses.UserResponse;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String demail);
    Page<User> findByRoleName(String roleName, Pageable pageable);

}
