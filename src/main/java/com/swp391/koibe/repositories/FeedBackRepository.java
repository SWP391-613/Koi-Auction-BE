package com.swp391.koibe.repositories;

import com.swp391.koibe.domain.feedback.Feedback;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedBackRepository extends JpaRepository<Feedback, Long> {

    Boolean existsByUserIdAndOrderId(Long userId, Long orderId);
    Optional<Feedback> findByOrderId(Long orderId);

}
