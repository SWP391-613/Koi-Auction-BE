package com.swp391.koibe.utils;

import com.swp391.koibe.models.*;
import com.swp391.koibe.repositories.AuctionRepository;
import com.swp391.koibe.repositories.KoiRepository;
import com.swp391.koibe.repositories.OrderRepository;
import com.swp391.koibe.responses.*;
import com.swp391.koibe.responses.order.OrderDetailResponse;
import com.swp391.koibe.responses.order.OrderResponse;
import java.time.format.DateTimeFormatter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class DTOConverter {

    private final KoiRepository koiRepository;
    private final AuctionRepository auctionRepository;
    private final OrderRepository orderRepository;

    public static UserResponse convertToUserDTO(User user) {
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

    public BreederResponse convertToBreederDTO(User user) {
        return new BreederResponse(convertToUserDTO(user), koiRepository.countKoisByOwnerId(user.getId()));
    }

    public StaffResponse convertToStaffDTO(User user) {
        return new StaffResponse(convertToUserDTO(user), auctionRepository.countAuctionsByAuctioneerId(user.getId()));
    }

    public MemberResponse convertToMemberDTO(User user) {
        return new MemberResponse(convertToUserDTO(user), orderRepository.countOrdersByMemberId(user.getId()));
    }

    public CategoryResponse convertToCategoryDTO(Category category) {
        return CategoryResponse.builder()
                .id(category.getId())
                .name(category.getName())
                .koiCount(koiRepository.countKoisByCategoryId(category.getId()))
                .build();
    }

    public static KoiResponse convertToKoiDTO(Koi koi) {
        return KoiResponse.builder()
                .id(koi.getId())
                .name(koi.getName())
                .sex(koi.getSex())
                .length(koi.getLength())
                .yearBorn(koi.getYearBorn())
                .price(koi.getPrice())
                .statusName(koi.getStatus() != null ? koi.getStatus().getStatus() : null)
                .idDisplay(koi.getIsDisplay())
                .thumbnail(koi.getThumbnail())
                .description(koi.getDescription())
                .ownerId(koi.getOwner().getId())
                .categoryId(koi.getCategory().getId())
                .createdAt(koi.getCreatedAt())
                .updatedAt(koi.getUpdatedAt())
                .build();
    }

    public static KoiImageResponse convertToKoiImageDTO(KoiImage koiImage) {
        return KoiImageResponse.builder()
                .id(koiImage.getId())
                .koiId(koiImage.getKoi().getId())
                .imageUrl(koiImage.getImageUrl())
                .build();
    }

    public static AuctionResponse convertToAuctionDTO(Auction auction) {
        return AuctionResponse.builder()
                .id(auction.getId())
                .title(auction.getTitle())
                .startTime(String.valueOf(auction.getStartTime()))
                .endTime(String.valueOf(auction.getEndTime()))
                .status(auction.getStatus() != null ? auction.getStatus().getStatus() : null)
                .auctioneerId(auction.getAuctioneer().getId())
                .build();
    }

    public static AuctionKoiResponse convertToAuctionKoiDTO(AuctionKoi auctionKoi) {
        return AuctionKoiResponse.builder()
                .id(auctionKoi.getId())
                .auctionId(auctionKoi.getAuction().getId())
                .koiId(auctionKoi.getKoi().getId())
                .basePrice(auctionKoi.getBasePrice())
                .bidStep(auctionKoi.getBidStep())
                .bidMethod(auctionKoi.getBidMethod() != null ? String.valueOf(auctionKoi.getBidMethod()) : null)
                .currentBid(auctionKoi.getCurrentBid() == null ? 0 : auctionKoi.getCurrentBid())
                .currentBidderId(auctionKoi.getCurrentBidderId() == null ? 0 : auctionKoi.getCurrentBidderId())
                .isSold(auctionKoi.isSold())
                .build();
    }

    public static BidResponse convertToBidDTO(Bid bid) {
        return BidResponse.builder()
                .auctionKoiId(bid.getAuctionKoi().getId())
                .bidderId(bid.getBidder().getId())
                .bidAmount(bid.getBidAmount())
                .bidTime(bid.getBidTime().toString())
                .bidderName(String.format("%s %s", bid.getBidder().getFirstName(), bid.getBidder().getLastName()))
                .build();
    }

    public static OrderResponse fromOrder(Order order) {
        return OrderResponse
                .builder()
                .id(order.getId())
                .user(DTOConverter.convertToUserDTO(order.getUser()))
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
                .productId(DTOConverter.convertToKoiDTO(orderDetail.getKoi()))
                .price(orderDetail.getPrice())
                .numberOfProducts(orderDetail.getNumberOfProducts())
                .totalMoney(orderDetail.getTotalMoney())
                .build();
    }

    public static FeedbackResponse fromFeedback(Feedback feedback) {
        return FeedbackResponse.builder()
                .createAt(feedback.getCreatedAt())
                .rating(feedback.getRating())
                .content(feedback.getContent())
                .build();
    }

    public static PaymentResponse fromPayment(Payment payment) {
        return PaymentResponse.builder()
                .id(payment.getId())
                .paymentAmount(payment.getPaymentAmount())
                .paymentDate(payment.getPaymentDate())
                .paymentMethod(payment.getPaymentMethod())
                .paymentStatus(payment.getPaymentStatus().getStatus())
                .orderId(payment.getOrder() != null ? payment.getOrder().getId() : null)
                .user(DTOConverter.convertToUserDTO(payment.getUser()))
                .paymentType(payment.getPaymentType().getType())
                .bankNumber(payment.getBankNumber())
                .bankName(payment.getBankName())
                .build();
    }

}
