package com.swp391.koibe.repositories;

import com.swp391.koibe.enums.UserRole;
import com.swp391.koibe.models.Role;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {

    Optional<Role> findByUserRole(UserRole userRole);

}
