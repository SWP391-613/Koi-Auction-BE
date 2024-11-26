package com.swp391.koibe.repositories

import com.swp391.koibe.enums.UserRole
import com.swp391.koibe.models.Role
import com.swp391.koibe.models.User
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import java.util.*

interface UserRepository : JpaRepository<User, Long> {
    fun findByEmail(email: String): Optional<User>
    fun existsByEmail(email: String): Boolean
    fun findByPhoneNumber(phoneNumber: String): Optional<User>
    fun findByRole(role: Role, pageable: Pageable): Page<User>

    @Query("SELECT u FROM User u WHERE u.role.id = 2")
    fun findAllStaff(pageable: Pageable): Page<User>

    @Query("SELECT u FROM User u WHERE u.role.id = 1")
    fun findAllMember(pageable: Pageable): Page<User>

    @Query("SELECT u FROM User u WHERE u.role.id = 3")
    fun findAllBreeder(pageable: Pageable): Page<User>

    @Query("SELECT u FROM User u WHERE u.id = :id AND u.role.id = 2 AND u.isActive = true")
    fun findStaffById(id: Long): Optional<User>
    @Query("SELECT u FROM User u WHERE u.id = :id AND u.role.id = 3 AND u.isActive = true")
    fun findBreederById(id: Long): Optional<User>

    @Query("SELECT u FROM User u WHERE u.role.id = 2 AND u.isActive = true")
    fun findAllStaffWithActive(pageable: Pageable): Page<User>

    @Modifying
    @Query("UPDATE User u SET u.isActive = false WHERE u.id = :id")
    fun softDeleteUser(id: Long)

    @Modifying
    @Query("UPDATE User u SET u.isActive = true WHERE u.id = :id")
    fun restoreUser(id: Long)

    @Modifying
    @Query("UPDATE User u SET u.role.id = :roleId WHERE u.id = :id")
    fun updateRole(id: Long, roleId: Long)
}
