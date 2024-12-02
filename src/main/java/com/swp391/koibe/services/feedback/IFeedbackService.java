package com.swp391.koibe.services.feedback;


import com.swp391.koibe.dtos.FeedbackDTO;
import com.swp391.koibe.models.Feedback;

import com.swp391.koibe.responses.FeedbackResponse;
import com.swp391.koibe.responses.base.PageResponse;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Pageable;

public interface IFeedbackService {
    Feedback createFeedback(FeedbackDTO feedbackDTO);
    List<FeedbackResponse> getAllFeedbacks();
    Feedback updateFeedback(long id, FeedbackDTO feedbackDTO);
    void deleteFeedback(long id);
    Optional<Feedback> getFeedbackById(long id);
    Optional<Feedback> getFeedbackByOrderId(long orderId);
}
