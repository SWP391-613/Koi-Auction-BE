package com.swp391.koibe.repositories;

import com.swp391.koibe.domain.user.SocialAccount;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SocialAccountRepository extends JpaRepository<SocialAccount, Long> {

}
