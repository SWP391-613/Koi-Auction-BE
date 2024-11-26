package com.swp391.koibe.repositories

import com.swp391.koibe.enums.UserRole
import com.swp391.koibe.models.Role
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface RoleRepository : JpaRepository<Role, Long> {
    fun findByUserRole(userRole: UserRole): Optional<Role>
}
