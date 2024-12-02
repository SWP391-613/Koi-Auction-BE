package com.swp391.koibe.services.feedback;

import com.swp391.koibe.dtos.FeedbackDTO;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.metadata.PaginationMeta;
import com.swp391.koibe.models.Feedback;
import com.swp391.koibe.models.Order;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.FeedBackRepository;
import com.swp391.koibe.repositories.OrderRepository;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.responses.FeedbackResponse;
import com.swp391.koibe.responses.base.PageResponse;
import com.swp391.koibe.utils.DTOConverter;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class FeedbackService implements IFeedbackService {
    private final FeedBackRepository feedbackRepository;
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final DTOConverter dtoConverter;

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
    public List<FeedbackResponse> getAllFeedbacks() {
        return feedbackRepository.findAll().stream()
            .map(DTOConverter::fromFeedback)
            .collect(Collectors.toList());
    }

    @Override
    public Feedback updateFeedback(long id, FeedbackDTO feedbackDTO) {
        Feedback feedback = feedbackRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Feedback not found"));
        User existUser = userRepository.findById(feedbackDTO.userId())
                .orElseThrow(() -> new DataNotFoundException("User not found"));
        Order existOrder = orderRepository.findById(feedbackDTO.orderId())
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
    public Optional<Feedback> getFeedbackById(long id) {
        return Optional.ofNullable(feedbackRepository.findById(id)
                                       .orElseThrow(
                                           () -> new DataNotFoundException("Feedback not found")));
    }

    @Override
    public Optional<Feedback> getFeedbackByOrderId(long orderId) {
        return Optional.ofNullable(feedbackRepository.findByOrderId(orderId)
                                       .orElseThrow(
                                           () -> new DataNotFoundException("Feedback not found")));
    }
}
