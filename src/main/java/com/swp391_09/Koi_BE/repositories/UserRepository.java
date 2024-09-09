package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

}
