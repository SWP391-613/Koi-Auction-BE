package com.swp391.koibe.dtos.order;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.dtos.CartItemDTO;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderDTO {
    @JsonProperty("user_id")
    @Min(value = 1, message = "User's ID must be > 0")
    Long userId;

    @JsonProperty("first_name")
    String firstName;

    @JsonProperty("last_name")
    String lastName;

    String email;
    String status;
    String address;

    @JsonProperty("phone_number")
    @NotBlank(message = "Phone number is required")
    @Size(min = 5, message = "Phone number must be at least 5 characters")
    String phoneNumber;

    @JsonProperty("note")
    String note;

    @JsonProperty("total_money")
    @Min(value = 0, message = "Total money must be >= 0")
    @NotNull(message = "Total money is required")
    Float totalMoney;

    @JsonProperty("shipping_method")
    String shippingMethod;

    @JsonProperty("shipping_address")
    String shippingAddress;

    @JsonProperty("shipping_date")
    LocalDate shippingDate;

    @JsonProperty("payment_method")
    String paymentMethod;

    @JsonProperty("coupon_code")
    String couponCode;

    @JsonProperty("cart_items")
    List<CartItemDTO> cartItems;

}
