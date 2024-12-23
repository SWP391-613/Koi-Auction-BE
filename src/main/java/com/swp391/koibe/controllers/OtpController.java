package com.swp391.koibe.controllers;

import com.swp391.koibe.components.LocalizationUtils;
import com.swp391.koibe.dtos.VerifyUserDTO;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.OtpResponse;
import com.swp391.koibe.responses.base.ApiResponse;
import com.swp391.koibe.services.user.IUserService;
import com.swp391.koibe.utils.MessageKey;
import jakarta.mail.MessagingException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "${api.prefix}/otp")
@RequiredArgsConstructor
public class OtpController {

    private final MailController mailController;
    private final PhoneController phoneController;
    private final IUserService userService;
    private final LocalizationUtils localizationUtils;

    @GetMapping("/send")
    public ResponseEntity<?> sendOtp(@RequestParam String type, @RequestParam String recipient)
        throws MessagingException {
        return switch (type.toLowerCase()) {
            case "mail" -> mailController.sendOtp(recipient);
            case "phone" -> phoneController.sendPhoneOtp(recipient);
            default -> new ResponseEntity<>("Invalid type specified", HttpStatus.BAD_REQUEST);
        };
    }

    @PostMapping("/verify")
    public ResponseEntity<ApiResponse<OtpResponse>> verifiedUserNotLogin(
        @Valid @RequestBody VerifyUserDTO verifyUserDTO,
        BindingResult result
    ) throws Exception {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }
        User user = userService.getUserByEmail(verifyUserDTO.email());
        userService.verifyOtpIsCorrect(user.getId(), verifyUserDTO.otp());
        return ResponseEntity.ok().body(
            ApiResponse.<OtpResponse>builder()
                .message(localizationUtils.getLocalizedMessage(MessageKey.OTP_IS_CORRECT))
                .isSuccess(true)
                .statusCode(HttpStatus.OK.value())
                .build());

    }

}

