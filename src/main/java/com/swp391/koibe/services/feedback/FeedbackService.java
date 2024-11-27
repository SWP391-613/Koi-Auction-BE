package com.swp391.koibe.services.feedback;

import com.swp391.koibe.dtos.FeedbackDTO;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.Feedback;
import com.swp391.koibe.models.Order;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.FeedBackRepository;
import com.swp391.koibe.repositories.OrderRepository;
import com.swp391.koibe.repositories.UserRepository;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class FeedbackService implements IFeedbackService {
    private final FeedBackRepository feedbackRepository;
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;

    @Override
    public Feedback createFeedback(FeedbackDTO feedbackDTO) {

        if (feedbackRepository.existsByUserIdAndOrderId(feedbackDTO.userId(), feedbackDTO.orderId())) {
            throw new DataAlreadyExistException("Feedback already exists");
        }
        User user = userRepository.findById(feedbackDTO.userId())
                .orElseThrow(() -> new DataNotFoundException("User not found: " + feedbackDTO.userId()));
        Order order = orderRepository.findById(feedbackDTO.orderId())
                .orElseThrow(() -> new DataNotFoundException("Order not found: " + feedbackDTO.orderId()));

        if (order.getUser().getId() != user.getId()) {
            throw new DataNotFoundException("User not found in order");
        }

        Feedback feedback = Feedback.builder()
                .content(feedbackDTO.content())
                .rating(feedbackDTO.rating())
                .user(user)
                .order(order)
                .createdAt(LocalDateTime.now())
                .build();
        return feedbackRepository.save(feedback);
    }

    @Override
    public List<Feedback> getAllFeedbacks() {
        List<Feedback> feedbacks = feedbackRepository.findAll();
        if (feedbacks.isEmpty()) {
            throw new DataNotFoundException("Feedback not found");
        }
        return feedbacks;
    }

    @Override
    public Feedback updateFeedback(long id, FeedbackDTO feedbackDTO) {
        Feedback feedback = feedbackRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Feedback not found"));
        User existUser = userRepository.findById(feedbackDTO.userId())
                .orElseThrow(() -> new DataNotFoundException("User not found"));
        Order existOrder = orderRepository.findById(feedbackDTO.userId())
                .orElseThrow(() -> new DataNotFoundException("Order not found"));
        feedback.setContent(feedbackDTO.content());
        feedback.setRating(feedbackDTO.rating());
        feedback.setUser(existUser);
        feedback.setOrder(existOrder);

        return feedbackRepository.save(feedback);
    }

    @Override
    public void deleteFeedback(long id) {
        Feedback feedback = feedbackRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Feedback not found"));
        feedbackRepository.delete(feedback);
    }

    @Override
    public Feedback getFeedbackById(long id) {
        return feedbackRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Feedback not found"));
    }

    @Override
    public Feedback getFeedbackByOrderId(long orderId) {
        if (!orderRepository.existsById(orderId)) {
            return null;
        }
        return feedbackRepository.findByOrderId(orderId).orElse(null);
    }
}
