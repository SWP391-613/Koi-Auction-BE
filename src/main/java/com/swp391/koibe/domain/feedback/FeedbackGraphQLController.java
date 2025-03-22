package com.swp391.koibe.domain.feedback;

import com.swp391.koibe.components.LocalizationUtils;
import com.swp391.koibe.enums.OrderStatus;
import com.swp391.koibe.domain.order.Order;
import com.swp391.koibe.domain.order.IOrderService;
import com.swp391.koibe.utils.DTOConverter;
import lombok.RequiredArgsConstructor;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class FeedbackGraphQLController {

    private final IFeedbackService feedbackService;
    private final LocalizationUtils localizationUtils;
    private final IOrderService orderService;

    @QueryMapping
    @PreAuthorize("permitAll()")
    public List<FeedbackResponse> getAllFeedbacks() {
        return feedbackService.getAllFeedbacks();
    }

    @QueryMapping
    public FeedbackResponse getFeedbackById(@Argument Long id) {
        return DTOConverter.fromFeedback(feedbackService.getFeedbackById(id).get());
    }

    @QueryMapping
    public FeedbackResponse getFeedbackByOrderId(@Argument Long orderId) {
        return DTOConverter.fromFeedback(feedbackService.getFeedbackByOrderId(orderId).get());
    }

    @MutationMapping
    public FeedbackResponse createFeedback(@Argument FeedbackDTO feedback) {
        // Check if the order is in DELIVERED status
        Order order = orderService.getOrder(feedback.orderId());
        if (order.getStatus() != OrderStatus.DELIVERED) {
            throw new IllegalStateException("Feedback can only be submitted for delivered orders.");
        }

        // Check if feedback already exists for this order
        if (feedbackService.getFeedbackByOrderId(feedback.orderId()).isPresent()) {
            throw new IllegalStateException("Feedback has already been submitted for this order.");
        }

        return DTOConverter.fromFeedback(feedbackService.createFeedback(feedback));
    }

    @MutationMapping
    public FeedbackResponse updateFeedback(@Argument Long id, @Argument FeedbackDTO feedback) {
        return DTOConverter.fromFeedback(feedbackService.updateFeedback(id, feedback));
    }

    @MutationMapping
    public Boolean deleteFeedback(@Argument Long id) {
        try {
            feedbackService.deleteFeedback(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
