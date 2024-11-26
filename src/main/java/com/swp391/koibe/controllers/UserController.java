package com.swp391.koibe.controllers;

import com.swp391.koibe.annotations.RetryAndBlock;
import com.swp391.koibe.components.LocalizationUtils;
import com.swp391.koibe.dtos.UpdateUserDTO;
import com.swp391.koibe.dtos.UserLoginDTO;
import com.swp391.koibe.dtos.UserRegisterDTO;
import com.swp391.koibe.dtos.VerifyUserDTO;
import com.swp391.koibe.exceptions.MalformBehaviourException;
import com.swp391.koibe.exceptions.MalformDataException;
import com.swp391.koibe.exceptions.MethodArgumentNotValidException;
import com.swp391.koibe.exceptions.PermissionDeniedException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.exceptions.base.DataWrongFormatException;
import com.swp391.koibe.models.Token;
import com.swp391.koibe.models.User;
import com.swp391.koibe.responses.LoginResponse;
import com.swp391.koibe.responses.LogoutResponse;
import com.swp391.koibe.responses.OtpResponse;
import com.swp391.koibe.responses.RegisterResponse;
import com.swp391.koibe.responses.UpdateUserResponse;
import com.swp391.koibe.responses.UserResponse;
import com.swp391.koibe.services.token.TokenService;
import com.swp391.koibe.services.user.IUserService;
import com.swp391.koibe.utils.DTOConverter;
import com.swp391.koibe.utils.MessageKey;
import io.micrometer.core.annotation.Timed;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final IUserService userService;
    private final LocalizationUtils localizationUtils;
    private final TokenService tokenService;

    @GetMapping("/{id}")
    public ResponseEntity<UserResponse> getUserById(
        @PathVariable Long id
    ) {
        return ResponseEntity.ok(DTOConverter.convertToUserDTO(userService.getUserById(id)));
    }

    @Timed(
        value = "custom.login.requests",
        extraTags = {"uri", "/api/v1/users/login"},
        description = "Track login request count")
    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(
        @RequestBody @Valid UserLoginDTO userLoginDTO,
        BindingResult result,
        HttpServletRequest request) throws Exception {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        String token = userService.login(userLoginDTO.email(), userLoginDTO.password());
        String userAgent = request.getHeader("User-Agent");
        User userDetail = userService.getUserDetailsFromToken(token);
        Token jwtToken = tokenService.addToken(userDetail, token, isMobileDevice(userAgent));
        log.info("User logged in successfully");
        return ResponseEntity.ok(LoginResponse.builder()
                                     .message(localizationUtils.getLocalizedMessage(
                                         MessageKey.LOGIN_SUCCESSFULLY))
                                     .token(jwtToken.getToken())
                                     .tokenType(jwtToken.getTokenType())
                                     .refreshToken(jwtToken.getRefreshToken())
                                     .username(userDetail.getUsername())
                                     .roles(userDetail.getAuthorities().stream()
                                                .map(GrantedAuthority::getAuthority).toList())
                                     .id(userDetail.getId())
                                     .build());
    }

    private boolean isMobileDevice(String userAgent) {
        // Kiểm tra User-Agent header để xác định thiết bị di động
        if (userAgent == null) {
            return false;
        }
        return userAgent.toLowerCase().contains("mobile");
    }

    @PostMapping("/details")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_MEMBER', 'ROLE_STAFF', 'ROLE_BREEDER')")
    public ResponseEntity<UserResponse> takeUserDetailsFromToken(
        @RequestHeader("Authorization") String authorizationHeader
    ) {
        try {
            String extractedToken = authorizationHeader.substring(
                7); // Loại bỏ "Bearer " từ chuỗi token
            User user = userService.getUserDetailsFromToken(extractedToken);
            return ResponseEntity.ok(DTOConverter.convertToUserDTO(user));
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // PUT: localhost:4000/api/v1/users/4/deposit/100
    // Header: Authorization Bearer token
    @PutMapping("/{userId}/deposit/{payment}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_MEMBER', 'ROLE_STAFF', 'ROLE_BREEDER')")
    public ResponseEntity<String> deposit(
        @PathVariable long userId,
        @PathVariable long payment
    ) {

        if (payment <= 0) {
            throw new MalformDataException("Payment must be greater than 0.");
        }

        try {
            userService.updateAccountBalance(userId, payment);
            return ResponseEntity.ok().body("Successfully deposited.");
        } catch (DataNotFoundException e) {
            return ResponseEntity.badRequest().body("User not found.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @Timed(
        value = "custom.register.requests",
        extraTags = {"uri", "/api/v1/users/register"},
        description = "Track register request count")
    @PostMapping("/register")
    public ResponseEntity<RegisterResponse> createUser(
        @RequestBody @Valid UserRegisterDTO userRegisterDTO,
        BindingResult result) {

        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        try {
            User user = userService.createUser(userRegisterDTO);
            log.info("New user registered successfully");
            return ResponseEntity.status(HttpStatus.CREATED).body(
                RegisterResponse.builder()
                    .message(localizationUtils.getLocalizedMessage(MessageKey.REGISTER_SUCCESSFULLY))
                    .statusCode(HttpStatus.CREATED.value())
                    .isSuccess(true)
                    .singleData(DTOConverter.convertToUserDTO(user))
                    .build());
        } catch (DataWrongFormatException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                RegisterResponse.builder()
                    .message(localizationUtils.getLocalizedMessage(MessageKey.WRONG_FORMAT))
                    .statusCode(HttpStatus.BAD_REQUEST.value())
                    .isSuccess(false)
                    .reason(e.getMessage())
                    .build());
        } catch (MalformBehaviourException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                RegisterResponse.builder()
                    .message(localizationUtils.getLocalizedMessage(MessageKey.MALFORMED_BEHAVIOUR))
                    .statusCode(HttpStatus.BAD_REQUEST.value())
                    .isSuccess(false)
                    .reason(e.getMessage())
                    .build());
        } catch (DataIntegrityViolationException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(
                RegisterResponse.builder()
                    .message(
                        localizationUtils.getLocalizedMessage(MessageKey.EMAIL_ALREADY_EXISTS))
                    .statusCode(HttpStatus.CONFLICT.value())
                    .isSuccess(false)
                    .reason(e.getMessage())
                    .build());
        } catch (PermissionDeniedException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(
                RegisterResponse.builder()
                    .message(localizationUtils.getLocalizedMessage(MessageKey.PERMISSION_DENIED))
                    .statusCode(HttpStatus.FORBIDDEN.value())
                    .isSuccess(false)
                    .reason(e.getMessage())
                    .build());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                RegisterResponse.builder()
                    .message(localizationUtils.getLocalizedMessage(MessageKey.REGISTER_FAILED))
                    .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .isSuccess(false)
                    .reason(e.getMessage())
                    .build());
        }
    }

    @PutMapping("/details/{userId}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_MEMBER', 'ROLE_STAFF', 'ROLE_BREEDER')")
    public ResponseEntity<?> updateUserDetails(
        @PathVariable Long userId,
        @Valid @RequestBody UpdateUserDTO updatedUserDTO,
        @RequestHeader("Authorization") String authorizationHeader,
        BindingResult result
    ) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        UpdateUserResponse updateUserResponse = new UpdateUserResponse();
        try {
            String extractedToken = authorizationHeader.substring(7);
            User user = userService.getUserDetailsFromToken(extractedToken);
            // Ensure that the user making the request matches the user being updated
            if (!Objects.equals(user.getId(), userId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }
            User updatedUser = userService.updateUser(userId, updatedUserDTO);
            updateUserResponse.setMessage(
                localizationUtils.getLocalizedMessage(MessageKey.UPDATE_USER_SUCCESSFULLY));
            updateUserResponse.setUserResponse(DTOConverter.convertToUserDTO(updatedUser));
            return ResponseEntity.ok(updateUserResponse);
        } catch (Exception e) {
            updateUserResponse.setMessage("Fail to update user details");
            updateUserResponse.setReason(e.getMessage());
            return ResponseEntity.badRequest().body(updateUserResponse);
        }
    }

    @PutMapping("/block/{userId}/{active}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_MEMBER', 'ROLE_STAFF', 'ROLE_BREEDER')")
    public ResponseEntity<String> blockOrEnable(
        @Valid @PathVariable long userId,
        @Valid @PathVariable int active
    ) {
        try {
            userService.blockOrEnable(userId, active > 0);
            String message =
                active > 0 ? "Successfully enabled the user." : "Successfully blocked the user.";
            return ResponseEntity.ok().body(message);
        } catch (DataNotFoundException e) {
            return ResponseEntity.badRequest().body("User not found.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PutMapping("/verify/{otp}")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_MEMBER', 'ROLE_STAFF', 'ROLE_BREEDER')")
    public ResponseEntity<OtpResponse> verifiedUser(
        @PathVariable int otp,
        @RequestHeader("Authorization") String authorizationHeader
    ) {
        OtpResponse otpResponse = new OtpResponse();
        try {
            String extractedToken = authorizationHeader.substring(7);
            User user = userService.getUserDetailsFromToken(extractedToken);
            userService.verifyOtpToVerifyUser(user.getId(), String.valueOf(otp));
            otpResponse.setMessage(
                localizationUtils.getLocalizedMessage(MessageKey.VERIFY_USER_SUCCESSFULLY));
            return ResponseEntity.ok().body(otpResponse);
        } catch (Exception e) {
            otpResponse.setMessage(
                localizationUtils.getLocalizedMessage(MessageKey.VERIFY_USER_FAILED));
            otpResponse.setReason(e.getMessage());
            return ResponseEntity.badRequest().body(otpResponse);
        }
    }

    @Timed(
        value = "custom.verify.requests",
        extraTags = {"uri", "/api/v1/users/verify"},
        description = "Track verify request count")
    @RetryAndBlock(maxAttempts = 3, blockDurationSeconds = 3600, maxDailyAttempts = 6)
    @PostMapping("/verify")
    public ResponseEntity<OtpResponse> verifiedUserNotLogin(
        @Valid @RequestBody VerifyUserDTO verifyUserDTO,
        BindingResult result
    ) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }

        OtpResponse otpResponse = new OtpResponse();
        try {
            User user = userService.getUserByEmail(verifyUserDTO.email());
            userService.verifyOtpToVerifyUser(user.getId(), verifyUserDTO.otp());
            otpResponse.setMessage(
                localizationUtils.getLocalizedMessage(MessageKey.VERIFY_USER_SUCCESSFULLY));
            return ResponseEntity.ok().body(otpResponse);
        } catch (Exception e) {
            otpResponse.setMessage(
                localizationUtils.getLocalizedMessage(MessageKey.VERIFY_USER_FAILED));
            otpResponse.setReason(e.getMessage());
            return ResponseEntity.badRequest().body(otpResponse);
        }
    }

    @Timed(
        value = "custom.logout.requests",
        extraTags = {"uri", "/api/v1/users/logout"},
        description = "Track logout request count")
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_MEMBER', 'ROLE_STAFF', 'ROLE_BREEDER')")
    @PostMapping("/logout")
    public ResponseEntity<LogoutResponse> logout(
        @RequestHeader("Authorization") String authorizationHeader
    ) {
        LogoutResponse logoutResponse = new LogoutResponse();
        try {
            String extractedToken = authorizationHeader.substring(7);
            User user = userService.getUserDetailsFromToken(extractedToken);
            tokenService.deleteToken(extractedToken, user); //revoke token
            logoutResponse.setMessage(
                localizationUtils.getLocalizedMessage(MessageKey.LOGOUT_SUCCESSFULLY));
            return ResponseEntity.ok().body(logoutResponse);
        } catch (Exception e) {
            logoutResponse.setMessage(
                localizationUtils.getLocalizedMessage(MessageKey.LOGOUT_FAILED));
            logoutResponse.setReason(e.getMessage());
            return ResponseEntity.badRequest().body(logoutResponse);
        }
    }

    @PutMapping("/{id}/update-role/{roleId}")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public ResponseEntity<?> updateRole(
        @PathVariable long id,
        @PathVariable long roleId
    ) {
        userService.updateRole(id, roleId);
        return ResponseEntity.ok("Update role successfully");
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public ResponseEntity<?> deleteUser(@PathVariable long id) {
        userService.softDeleteUser(id);
        return ResponseEntity.ok("Delete user successfully");
    }

    @PutMapping("/{id}/restore")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public ResponseEntity<?> restoreUser(@PathVariable long id) {
        userService.restoreUser(id);
        return ResponseEntity.ok("Restore user successfully");
    }

}
