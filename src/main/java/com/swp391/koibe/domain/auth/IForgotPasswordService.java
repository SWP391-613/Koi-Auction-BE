package com.swp391.koibe.domain.auth;

import com.swp391.koibe.domain.user.User;
import jakarta.mail.MessagingException;

public interface IForgotPasswordService {

    void sendEmailOtp(User existingUser) throws MessagingException;

}
