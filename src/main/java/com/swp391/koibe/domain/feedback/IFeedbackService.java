package com.swp391.koibe.domain.feedback;


import java.util.List;
import java.util.Optional;

public interface IFeedbackService {
    Feedback createFeedback(FeedbackDTO feedbackDTO);
    List<FeedbackResponse> getAllFeedbacks();
    Feedback updateFeedback(long id, FeedbackDTO feedbackDTO);
    void deleteFeedback(long id);
    Optional<Feedback> getFeedbackById(long id);
    Optional<Feedback> getFeedbackByOrderId(long orderId);
}
