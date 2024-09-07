package com.swp391_09.Koi_BE.repositories;

import com.swp391_09.Koi_BE.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

}
