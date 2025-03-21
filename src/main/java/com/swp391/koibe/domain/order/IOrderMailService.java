package com.swp391.koibe.domain.order;

import com.swp391.koibe.domain.user.User;
import jakarta.mail.MessagingException;
import org.thymeleaf.context.Context;

public interface IOrderMailService {

    void sendOrderCreatedEmailToUser(Order order,
                                     String subject,
                                     String templateName,
                                     Context context) throws MessagingException;
    void sendOrderCancelledToUser(User user,
                                  String subject,
                                  String templateName,
                                  Context context) throws MessagingException;
}
