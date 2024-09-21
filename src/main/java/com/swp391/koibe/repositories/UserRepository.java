package com.swp391.koibe.repositories;

import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.UserResponse;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String demail);
    Page<User> findByRoleName(String roleName, Pageable pageable);

}
