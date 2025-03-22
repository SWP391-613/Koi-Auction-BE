package com.swp391.koibe.domain.mail;

import com.swp391.koibe.annotations.SkipEmailValidation;
import com.swp391.koibe.constants.EmailSubject;
import com.swp391.koibe.domain.auction.IAuctionContract;
import com.swp391.koibe.domain.auction.IAuctionMailService;
import com.swp391.koibe.domain.otp.IOtpService;
import com.swp391.koibe.domain.otp.Otp;
import com.swp391.koibe.domain.role.UpdateRolePurposeDTO;
import com.swp391.koibe.domain.user.IUserService;
import com.swp391.koibe.domain.user.User;
import com.swp391.koibe.enums.EUpdateRole;
import com.swp391.koibe.enums.EmailBlockReasonEnum;
import com.swp391.koibe.enums.EmailCategoriesEnum;
import com.swp391.koibe.exceptions.InvalidApiPathVariableException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.utils.OtpUtils;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.thymeleaf.context.Context;

@Slf4j
@RequestMapping(path = "${api.prefix}/mail")
@RestController
@RequiredArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE, makeFinal = true)
@Tag(name = "Mail", description = "APIs for sending mail")
public class MailController {

    IMailService mailService;
    HttpServletRequest request;
    IOtpService otpService;
    IUserService userService;
    IAuctionMailService auctionMailService;

    //GET: localhost:4000/api/v1/mail/update-role?updateRole=STAFF
    @PostMapping("/update-role")
    @PreAuthorize("hasAnyRole('ROLE_MEMBER')")
    @SkipEmailValidation
    public ResponseEntity<?> sendOtp(
        @RequestParam EUpdateRole updateRole,
        @Valid @RequestBody UpdateRolePurposeDTO updateRolePurposeDTO,
        BindingResult result
    ) throws Exception {
        if(result.hasErrors()) throw new MethodArgumentNotValidException(result);

        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.findByUsername(userDetails.getUsername());
        Context context = new Context();
        context.setVariable("name", user.getFirstName());
        context.setVariable("sendFromEmail", user.getEmail());
        context.setVariable("role", updateRole);
        context.setVariable("purpose", updateRolePurposeDTO.purpose());
        mailService.sendMail("hoangclw@gmail.com", EmailSubject.subjectRequestUpdateRole(),
                             EmailCategoriesEnum.UPDATE_ROLE.getType(), context);
        mailService.sendMail(user.getEmail(), EmailSubject.subjectRequestUpdateRole(),
                             EmailCategoriesEnum.PROCESSING_UPDATE_ROLE.getType(), context);
        MailResponse response = new MailResponse("Mail sent successfully");
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    //api: /otp/send?type=email&recipient=abc@gmail
    public ResponseEntity<MailResponse> sendOtp(@RequestParam String toEmail)
        throws MessagingException {
        User user = (User) request.getAttribute("validatedEmail");

        String name = user.getFirstName();
        Context context = new Context();
        String otp = OtpUtils.generateOtp();
        context.setVariable("name", name);
        context.setVariable("otp", otp);
        mailService.sendMail(toEmail, EmailSubject.subjectGreeting(name),
                             EmailCategoriesEnum.OTP.getType(),
                             context);
        MailResponse response = new MailResponse("Mail sent successfully");

        Otp otpEntity = Otp.builder()
            .email(toEmail)
            .otp(otp)
            .expiredAt(LocalDateTime.now().plusMinutes(5))
            .isUsed(false)
            .isExpired(false)
            .build();

        otpService.createOtp(otpEntity);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/block")
    ResponseEntity<MailResponse> sendBlockAccount(@RequestParam String toEmail)
        throws MessagingException {
        User user = (User) request.getAttribute("validatedEmail");
        Context context = new Context();
        context.setVariable("reason", EmailBlockReasonEnum.ABUSE.getReason());
        mailService.sendMail(toEmail, EmailSubject.subjectBlockEmail(user.getFirstName()),
                             EmailCategoriesEnum.BLOCK_ACCOUNT.getType(), context);
        MailResponse response = new MailResponse("Mail sent successfully");
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping(path = "/forgotPassword")
    ResponseEntity<MailResponse> sendForgotPassword(@RequestParam String toEmail)
        throws MessagingException {
        User user = (User) request.getAttribute("validatedEmail");
        String name = user.getFirstName();
        Context context = new Context();
        String otp = OtpUtils.generateOtp();
        context.setVariable("name", name);
        context.setVariable("otp", otp);
        mailService.sendMail(toEmail, EmailSubject.subjectGreeting(name),
                             EmailCategoriesEnum.FORGOT_PASSWORD.getType(), context);
        MailResponse response = new MailResponse("Mail sent successfully");
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/auction-mail/end/{auctionId}")
    public void sendAuctionClosedEmailToAllUser(
        @PathVariable
        long auctionId) throws MessagingException{

        if(auctionId <= 0 ){
            throw new InvalidApiPathVariableException("Invalid auction id");
        }

        try{
            Context context = new Context();
            auctionMailService.sendAuctionClosedEmailToAllUser(
                auctionId,
                "Auction Closed",
                "auctionClosed",
                context);

        }catch (Exception e){
            log.error("Failed to send mail auction closed to all users: {}", e.getMessage());
            throw new MessagingException("Failed to send mail auction closed to all users" + e.getMessage());
        }

    }

}