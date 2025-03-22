package com.swp391.koibe.utils;

import com.swp391.koibe.domain.auction.Auction;
import com.swp391.koibe.domain.auction.AuctionKoi;
import com.swp391.koibe.domain.auction.AuctionKoiPort;
import com.swp391.koibe.domain.auction.AuctionResponse;
import com.swp391.koibe.domain.auction.Bid;
import com.swp391.koibe.domain.auction.BidResponse;
import com.swp391.koibe.domain.category.Category;
import com.swp391.koibe.domain.category.CategoryResponse;
import com.swp391.koibe.domain.feedback.Feedback;
import com.swp391.koibe.domain.feedback.FeedbackResponse;
import com.swp391.koibe.domain.koi.Koi;
import com.swp391.koibe.domain.koi.KoiImage;
import com.swp391.koibe.domain.koi.KoiInAuctionResponse;
import com.swp391.koibe.domain.koi.KoiPort;
import com.swp391.koibe.domain.koi.KoiPort.KoiImageResponse;
import com.swp391.koibe.domain.order.Order;
import com.swp391.koibe.domain.order.OrderDetail;
import com.swp391.koibe.domain.order.OrderDetailResponse;
import com.swp391.koibe.domain.order.OrderResponse;
import com.swp391.koibe.domain.payment.Payment;
import com.swp391.koibe.domain.payment.PaymentResponse;
import com.swp391.koibe.domain.role.Role;
import com.swp391.koibe.domain.role.RoleResponse;
import com.swp391.koibe.domain.user.BreederResponse;
import com.swp391.koibe.domain.user.MemberResponse;
import com.swp391.koibe.domain.user.StaffResponse;
import com.swp391.koibe.domain.user.User;
import com.swp391.koibe.domain.user.UserResponse;
import com.swp391.koibe.repositories.AuctionRepository;
import com.swp391.koibe.repositories.KoiRepository;
import com.swp391.koibe.repositories.OrderRepository;
import java.time.format.DateTimeFormatter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class DTOConverter {

    private final KoiRepository koiRepository;
    private final AuctionRepository auctionRepository;
    private final OrderRepository orderRepository;

    public static UserResponse toUserResponse(User user) {
        return new UserResponse(
            user.getId(),
            user.getFirstName(),
            user.getLastName(),
            user.getPhoneNumber(),
            user.getEmail(),
            user.getAddress(),
            user.getPassword(),
            user.isActive() ? 1 : 0,
            user.isSubscription() ? 1 : 0,
            user.getStatus() != null ? user.getStatus().getStatus() : null,
            String.valueOf(user.getDob()).split(" ")[0],
            user.getAvatarUrl(),
            user.getGoogleAccountId(),
            user.getRole() != null ? user.getRole().getUserRole().name() : null,
            user.getAccountBalance(),
            user.getCreatedAt() != null ? user.getCreatedAt().format(DateTimeFormatter.ISO_DATE_TIME) : null,
            user.getUpdatedAt() != null ? user.getUpdatedAt().format(DateTimeFormatter.ISO_DATE_TIME) : null
        );
    }

    public BreederResponse toBreederResponse(User user) {
        return new BreederResponse(toUserResponse(user), koiRepository.countKoisByOwnerId(user.getId()));
    }

    public StaffResponse toStaffResponse(User user) {
        return new StaffResponse(toUserResponse(user), auctionRepository.countAuctionsByAuctioneerId(user.getId()));
    }

    public MemberResponse toMemberResponse(User user) {
        return new MemberResponse(toUserResponse(user), orderRepository.countOrdersByMemberId(user.getId()));
    }

    public CategoryResponse toCategoryResponse(Category category) {
        return new CategoryResponse(category.getId(), category.getName(), koiRepository.countKoisByCategoryId(category.getId()));
    }

    public static RoleResponse toRoleResponse(Role role) {
        return new RoleResponse(role.getId(), role.getUserRole());
    }

    public static KoiPort.KoiResponse toKoiResponse(Koi koi) {
        return new KoiPort.KoiResponse (
            koi.getId(),
            koi.getName(),
            koi.getSex(),
            koi.getLength(),
            koi.getYearBorn(),
            koi.getPrice(),
            koi.getStatus() != null ? koi.getStatus().getStatus() : null,
            koi.getIsDisplay(),
            koi.getThumbnail(),
            koi.getDescription(),
            koi.getOwner().getId(),
            koi.getCategory().getId(),
            koi.getCreatedAt(),
            koi.getUpdatedAt(),
            null
        );
    }

    public static KoiImageResponse toKoiImageResponse(KoiImage koiImage) {
        return new KoiImageResponse(koiImage.getId(), koiImage.getKoi().getId(), koiImage.getMediaMeta());
    }

    public static AuctionResponse toAuctionResponse(Auction auction) {
        return new  AuctionResponse(
            auction.getId(),
            auction.getTitle(),
            auction.getStartTime(),
            auction.getEndTime(),
            auction.getStatus() != null ? auction.getStatus() : null,
            auction.getAuctioneer().getId()
        );
    }

    public static AuctionKoiPort.AuctionKoiResponse toAuctionKoiResponse(AuctionKoi auctionKoi) {
        return new AuctionKoiPort.AuctionKoiResponse(
            auctionKoi.getId(),
            auctionKoi.getBasePrice(),
            auctionKoi.getCeilPrice(),
            auctionKoi.getBidStep(),
            auctionKoi.getBidMethod() != null ? auctionKoi.getBidMethod() : null,
            auctionKoi.getCurrentBid() == null ? 0 : auctionKoi.getCurrentBid(),
            auctionKoi.getCurrentBidderId() == null ? 0 : auctionKoi.getCurrentBidderId(),
            auctionKoi.getRevoked(),
            auctionKoi.isSold(),
            auctionKoi.getAuction().getId(),
            auctionKoi.getKoi().getId()
        );
    }

    public static BidResponse toBidResponse(Bid bid) {
        return new BidResponse(
            bid.getBidder().getId(),
            bid.getAuctionKoi().getId(),
            bid.getBidAmount(),
            bid.getBidTime().toString(),
            String.format("%s %s", bid.getBidder().getFirstName(), bid.getBidder().getLastName()));
    }

    public static OrderResponse toOrderResponse(Order order) {
        return OrderResponse
                .builder()
                .id(order.getId())
                .user(DTOConverter.toUserResponse(order.getUser()))
                .firstName(order.getFirstName())
                .lastName(order.getLastName())
                .phoneNumber(order.getPhoneNumber())
                .email(order.getEmail())
                .address(order.getAddress())
                .note(order.getNote())
                .orderDate(order.getOrderDate())
                .status(String.valueOf(order.getStatus()))
                .totalMoney(order.getTotalMoney())
                .shippingMethod(order.getShippingMethod())
                .shippingAddress(order.getShippingAddress())
                .shippingDate(order.getShippingDate())
                .paymentMethod(order.getPaymentMethod())
                .orderDetails(order.getOrderDetails())
                .build();
    }

    public static OrderDetailResponse fromOrderDetail(OrderDetail orderDetail) {
        return OrderDetailResponse
                .builder()
                .id(orderDetail.getId())
                .orderId(orderDetail.getOrder().getId())
                .productId(DTOConverter.toKoiResponse(orderDetail.getKoi()))
                .price(orderDetail.getPrice())
                .numberOfProducts(orderDetail.getNumberOfProducts())
                .totalMoney(orderDetail.getTotalMoney())
                .build();
    }

    public static FeedbackResponse fromFeedback(Feedback feedback) {
        return new FeedbackResponse(feedback.getId(), feedback.getContent(), feedback.getRating(), feedback.getCreatedAt());
    }

    public FeedbackResponse toFeedbackResponse(Feedback feedback) {
        return new FeedbackResponse(feedback.getId(), feedback.getContent(), feedback.getRating(), feedback.getCreatedAt());
    }

    public static PaymentResponse fromPayment(Payment payment) {
        return new PaymentResponse(
            payment.getId(),
            payment.getPaymentAmount(),
            payment.getPaymentDate(),
            payment.getPaymentMethod(),
            payment.getPaymentStatus().getStatus(),
            payment.getOrder() != null ? payment.getOrder().getId() : null,
            DTOConverter.toUserResponse(payment.getUser()),
            payment.getPaymentType().getType(),
            payment.getBankNumber(),
            payment.getBankName()
        );
    }

}
