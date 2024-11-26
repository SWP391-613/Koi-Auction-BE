package com.swp391.koibe.services.user;

import com.swp391.koibe.components.JwtTokenUtils;
import com.swp391.koibe.components.LocalizationUtils;
import com.swp391.koibe.constants.Regex;
import com.swp391.koibe.dtos.UpdatePasswordDTO;
import com.swp391.koibe.dtos.UpdateUserDTO;
import com.swp391.koibe.dtos.UserRegisterDTO;
import com.swp391.koibe.enums.EmailCategoriesEnum;
import com.swp391.koibe.enums.ProviderName;
import com.swp391.koibe.enums.UserRole;
import com.swp391.koibe.enums.UserStatus;
import com.swp391.koibe.exceptions.*;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.models.Otp;
import com.swp391.koibe.models.Role;
import com.swp391.koibe.models.SocialAccount;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.RoleRepository;
import com.swp391.koibe.repositories.SocialAccountRepository;
import com.swp391.koibe.repositories.UserRepository;
import com.swp391.koibe.services.mail.IMailService;
import com.swp391.koibe.services.otp.OtpService;
import com.swp391.koibe.services.role.RoleService;
import com.swp391.koibe.utils.MessageKey;
import com.swp391.koibe.utils.OtpUtils;
import jakarta.mail.MessagingException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thymeleaf.context.Context;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService implements IUserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtTokenUtils jwtTokenUtils;
    private final RoleRepository roleRepository;
    private final SocialAccountRepository socialAccountRepository;
    private final LocalizationUtils localizationUtils;
    private final IMailService mailService;
    private final OtpService otpService;
    private final RoleService roleService;

    @Override
    @Transactional
    public User createUser(UserRegisterDTO userRegisterDTO) throws Exception {
        if(!userRegisterDTO.password().matches(Regex.PASSWORD_REGEX)){
            throw new PasswordWrongFormatException("Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character");
        }

        if (!userRegisterDTO.password().equals(userRegisterDTO.confirmPassword())) {
            throw new MalformBehaviourException("Password and confirm password must be the same");
        }

        String email = userRegisterDTO.email();
        if (userRepository.existsByEmail(email)) {
            throw new DataIntegrityViolationException("Email already exists");
        }

        Role role = roleRepository.findById(userRegisterDTO.roleId())
                .orElseThrow(() -> new DataNotFoundException("Role not found"));

        if (role.getUserRole() == UserRole.MANAGER
            || role.getUserRole() == UserRole.STAFF
            || role.getUserRole() == UserRole.BREEDER
        ) {
            log.error("Cannot directly create this type account");
            throw new PermissionDeniedException("Cannot directly create this type account");
        }

        User newUser = User.builder()
                .firstName(userRegisterDTO.firstName())
                .lastName(userRegisterDTO.lastName())
                .email(userRegisterDTO.email())
                .password(userRegisterDTO.password())
                .address(userRegisterDTO.address())
                .isActive(true)
                .isSubscription(((userRegisterDTO.isSubscription() == null ? 0 : 1) != 0)) //force
                // subscription
                .status(UserStatus.UNVERIFIED)
                .dob(userRegisterDTO.dateOfBirth())
                .avatarUrl(Optional.ofNullable(userRegisterDTO.avatarUrl())
                           .orElse("https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg"))
                .googleAccountId(userRegisterDTO.googleAccountId())
                .accountBalance(0L) //new user has 0 money when register
                .build();

        newUser.setRole(role);

        // check if user are log in without google account, then encode password
        if (userRegisterDTO.googleAccountId() == 0) {
            newUser.setPassword(passwordEncoder.encode(userRegisterDTO.password()));
        }

        User savedUser = userRepository.save(newUser);

        // send OTP email
        String otp = OtpUtils.generateOtp();
        Context context = new Context();
        context.setVariable("name", savedUser.getFirstName());
        context.setVariable("otp", otp);

        mailService.sendMail(
                savedUser.getEmail(),
                "Verify your email",
                EmailCategoriesEnum.OTP.getType(),
                context
        );

        log.info("Send email otp to {}", savedUser.getEmail());

        Otp otpEntity = Otp.builder()
                .email(savedUser.getEmail())
                .otp(otp)
                .expiredAt(LocalDateTime.now().plusMinutes(5))
                .isUsed(false)
                .isExpired(false)
                .build();

        otpService.createOtp(otpEntity);

        return savedUser;
    }

    @Override
    public String login(String email, String password) throws Exception {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isEmpty()) {
            throw new DataNotFoundException(localizationUtils.getLocalizedMessage(MessageKey.WRONG_PHONE_PASSWORD));
        }
        User existingUser = optionalUser.get();
        if (existingUser.getGoogleAccountId() == 0) {
            if (!passwordEncoder.matches(password, existingUser.getPassword())) {
                throw new BadCredentialsException("Wrong email or password");
            }
        }

        if (!optionalUser.get().isActive()) {
            throw new DataNotFoundException(localizationUtils.getLocalizedMessage(MessageKey.USER_IS_LOCKED));
        }

        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(email, password, existingUser.getAuthorities());
        authenticationManager.authenticate(authenticationToken);
        return jwtTokenUtils.generateToken(existingUser);
    }

    @Override
    public String loginOrRegisterGoogle(String email, String name, String googleId, String avatarUrl) throws Exception {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        User user;
        SocialAccount socialAccount;

        if (optionalUser.isEmpty()) {
            // Register new user
            Role memberRole = roleRepository.findByUserRole(UserRole.MEMBER)
                    .orElseThrow(() -> new DataNotFoundException("Default MEMBER role not found"));

            User newUser = User.builder()
                    .firstName(name)
                    .email(email)
                    .googleAccountId(1)
                    .avatarUrl(avatarUrl)
                    .role(memberRole)
                    .accountBalance(0L)
                    .build();

            SocialAccount newSocialAccount = SocialAccount.builder()
                    .providerName(ProviderName.GOOGLE)
                    .name(name)
                    .email(email)
                    .build();


            user = userRepository.save(newUser);
            socialAccountRepository.save(newSocialAccount);
        } else {
            // Login existing user
            user = optionalUser.get();
            if (user.getGoogleAccountId() != 1) {
                throw new PermissionDeniedException("Cannot login with google account");
            }
        }

        return jwtTokenUtils.generateToken(user);
    }

    @Override
    public User getUserById(long id) throws DataNotFoundException {
        return userRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException(
                    localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)));
    }

    @Override
    public User getUserByEmail(String email) throws DataNotFoundException {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new DataNotFoundException("User not found: " + email));
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public User findByUsername(String username) throws DataNotFoundException {
        return userRepository.findByEmail(username)
                .orElseThrow(() -> new DataNotFoundException(
                        localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
                ));
    }

    @Transactional
    @Override
    public User updateUser(Long userId, UpdateUserDTO updatedUserDTO) throws Exception {
        // Find the existing user by userId
        User existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new DataNotFoundException(
                        localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
                ));

        // Check if the email is being changed and if it already exists for another user
        String newEmail = updatedUserDTO.email();

        if (newEmail != null && !newEmail.isEmpty()) {
            // Check if the new email is different from the current user's email
            if (!newEmail.equals(existingUser.getEmail())) {
                // Check if the new email is already in use by another user
                Optional<User> userWithNewEmail = userRepository.findByEmail(newEmail);

                if (userWithNewEmail.isPresent()) throw new EmailAlreadyUsedException("This email address is already registered");

                // If not, update the current user's email
                existingUser.setEmail(newEmail);
            }
            // If the email is the same as the current one, no changes are needed
        } else {
            throw new UpdateEmailException("This email cannot be empty");
        }

        // Check if the phone number is being changed and if it already exists for another user
        String newPhoneNumber = updatedUserDTO.phoneNumber();

        if (newPhoneNumber != null && !newPhoneNumber.isEmpty()) {
            // Check if the new phone number is different from the current user's phone number
            if (!newPhoneNumber.equals(existingUser.getPhoneNumber())) {
                // Check if the new phone number is already in use by another user
                Optional<User> userWithNewPhoneNumber = userRepository.findByPhoneNumber(newPhoneNumber);

                if (userWithNewPhoneNumber.isPresent()) throw new PhoneAlreadyUsedException("This phone number is already registered");

                // If not, update the current user's phone number
                existingUser.setPhoneNumber(newPhoneNumber);
            }
            // If the phone number is the same as the current one, no changes are needed
        } else {
            existingUser.setPhoneNumber(null);
        }

        // Update user information based on the DTO
        if (updatedUserDTO.firstName() != null) {
            existingUser.setFirstName(updatedUserDTO.firstName());
        }
        if (updatedUserDTO.lastName() != null) {
            existingUser.setLastName(updatedUserDTO.lastName());
        }
        if (updatedUserDTO.address() != null) {
            existingUser.setAddress(updatedUserDTO.address());
        }
        if (updatedUserDTO.status() != null) {
            existingUser.setStatus(UserStatus.valueOf(updatedUserDTO.status()));
        }
        if (updatedUserDTO.dob() != null) {
            existingUser.setDob(updatedUserDTO.dob());
        }
        if (updatedUserDTO.avatarUrl() != null) {
            existingUser.setAvatarUrl(updatedUserDTO.avatarUrl());
        }
        if (updatedUserDTO.googleAccountId() > 0) {
            existingUser.setGoogleAccountId(updatedUserDTO.googleAccountId());
        }

        // Update the password if it is provided in the DTO
        if (updatedUserDTO.password() != null
                && !updatedUserDTO.password().isEmpty()) {
            if (!updatedUserDTO.password().equals(updatedUserDTO.confirmPassword())) {
                throw new DataNotFoundException("Password and confirm password must be the same");
            }
            String newPassword = updatedUserDTO.password();
            String encodedPassword = passwordEncoder.encode(newPassword);
            existingUser.setPassword(encodedPassword);
        }
        //existingUser.setRole(updatedRole);
        // Save the updated user
        return userRepository.save(existingUser);
    }

    @Transactional
    @Override
    public User updateUserBalance(Long userId, Long payment) throws Exception {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new DataNotFoundException(
                        localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
                ));

        if (user.getAccountBalance() < payment) {
            throw new BiddingRuleException("Not enough money to make payment");
        }

        user.setAccountBalance(user.getAccountBalance() - payment);

        return userRepository.save(user);
    }

    @Transactional
    @Retryable(
        retryFor = { MessagingException.class },  // Retry only for specific exceptions
        maxAttempts = 3,                       // Maximum retry attempts
        backoff = @Backoff(delay = 2000)       // 2 seconds delay between retries
    )
    @Override
    public void updateAccountBalance(Long userId, Long payment) throws Exception {
        User existingUser = userRepository.findById(userId)
            .orElseThrow(() -> new DataNotFoundException(
                localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
            ));
        existingUser.setAccountBalance(existingUser.getAccountBalance() + payment);

        Context context = new Context();
        context.setVariable("name", existingUser.getFirstName() + " " + existingUser.getLastName());
        context.setVariable("amount", payment);
        context.setVariable("balance", existingUser.getAccountBalance());

        try {
            mailService.sendMail(
                existingUser.getEmail(),
                "Account balance updated",
                EmailCategoriesEnum.BALANCE_FLUCTUATION.getType(),
                context
            );
        } catch (MessagingException e) {
            log.error("Failed to send email to {}", existingUser.getEmail(), e);
            throw new MessagingException(String.format("Failed to send email to %s", existingUser.getEmail()));
        }

        log.info("User {} balance updated. New balance: {}", userId, existingUser.getAccountBalance());
        userRepository.save(existingUser);
    }

    //Token
    @Override
    public User getUserDetailsFromToken(String token) throws Exception {
        if (jwtTokenUtils.isTokenExpired(token)) {
            throw new ExpiredTokenException("Token is expired");
        }
        String email = jwtTokenUtils.extractEmail(token);
        Optional<User> user = userRepository.findByEmail(email);

        if (user.isPresent()) {
            return user.get();
        } else {
            throw new Exception(
                    localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
            );
        }
    }

    @Transactional
    @Override
    public void verifyOtpToVerifyUser(Long userId, String otp) throws Exception {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new DataNotFoundException(
                        localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
                ));

        if (user.getStatus() == UserStatus.VERIFIED) {
            throw new DataNotFoundException(
                    localizationUtils.getLocalizedMessage(MessageKey.USER_ALREADY_VERIFIED)
            );
        }

        if (user.getStatus() == UserStatus.BANNED) {
            throw new DataNotFoundException("User is banned");
        }

        Otp otpEntity = getOtpByEmailOtp(user.getEmail(), otp);

        //check the otp is expired or not
        if (otpEntity.getExpiredAt().isBefore(LocalDateTime.now())) {
            otpEntity.setExpired(true);
            otpService.disableOtp(otpEntity.getId());
            throw new DataNotFoundException(
                    localizationUtils.getLocalizedMessage(MessageKey.OTP_EXPIRED)
            );
        }

        if (!otpEntity.getOtp().equals(String.valueOf(otp))) throw new DataNotFoundException("Invalid OTP");

        otpEntity.setUsed(true);
        otpService.disableOtp(otpEntity.getId());
        user.setStatus(UserStatus.VERIFIED);
        userRepository.save(user);
    }

    @Transactional
    @Override
    public void verifyOtpIsCorrect(Long userId, String otp) throws Exception {
        User user = getUserById(userId);

        Otp otpEntity = getOtpByEmailOtp(user.getEmail(), otp);

        //check the otp is expired or not
        if (otpEntity.getExpiredAt().isBefore(LocalDateTime.now())) {
            otpEntity.setExpired(true);
            otpService.disableOtp(otpEntity.getId());
            throw new DataNotFoundException(
                localizationUtils.getLocalizedMessage(MessageKey.OTP_EXPIRED)
            );
        }

        if (!otpEntity.getOtp().equals(String.valueOf(otp))) throw new DataNotFoundException("Invalid OTP");

        otpEntity.setUsed(true);
        otpService.disableOtp(otpEntity.getId());
    }

    private Otp getOtpByEmailOtp(String email, String otp) {
        return otpService.getOtpByEmailOtp(email, otp)
            .orElseThrow(() -> new DataNotFoundException("OTP is not correct, please try again later"));
    }

    @Override
    public void bannedUser(Long userId) throws DataNotFoundException {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new DataNotFoundException(
                        localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
                ));

        user.setStatus(UserStatus.BANNED);
        userRepository.save(user);
    }

    @Override
    @Transactional
    public void updatePassword(UpdatePasswordDTO updatePasswordDTO) throws Exception {
        User existingUser = userRepository.findByEmail(updatePasswordDTO.email())
                .orElseThrow(() -> new DataNotFoundException(
                        localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
                ));

        if(!existingUser.isActive()){
            throw new MalformBehaviourException(MessageKey.USER_NOT_FOUND);
        }

        if(existingUser.getStatus() != UserStatus.VERIFIED){
            throw new MalformBehaviourException("User do not verified their account");
        }

        if(existingUser.getRole().getId() == 4){
            throw new PermissionDeniedException("Cannot change password for this account");
        }

        existingUser.setPassword(passwordEncoder.encode(updatePasswordDTO.newPassword()));

        mailService.sendMail(
                existingUser.getEmail(),
                "Password updated successfully",
                EmailCategoriesEnum.RESET_PASSWORD.getType(),
                new Context()
        );

        userRepository.save(existingUser);
    }

    //need send email
    @Override
    @Transactional
    public void softDeleteUser(Long userId) throws DataNotFoundException {
        User existingUser = getUserById(userId);
        if(!existingUser.isActive()) throw new MalformDataException("User is already deleted");
        userRepository.softDeleteUser(userId);
    }

    @Override
    @Transactional
    public void restoreUser(Long userId) throws DataNotFoundException {
        User existingUser = getUserById(userId);
        if(existingUser.isActive()) throw new MalformDataException("User is already active");
        userRepository.restoreUser(userId);
    }

    //need send email
    @Override
    @Transactional
    public void updateRole(long id, long roleId) throws DataNotFoundException {
        getUserById(id);
        roleService.getRoleById(roleId);
        userRepository.updateRole(id, roleId);
    }

    @Override
    public Page<User> findAll(String keyword, Pageable pageable) throws Exception {
        return null;
    }

    @Override
    @Transactional
    public void blockOrEnable(Long userId, Boolean active) throws DataNotFoundException {
        User existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new DataNotFoundException(
                        localizationUtils.getLocalizedMessage(MessageKey.USER_NOT_FOUND)
                ));
        existingUser.setActive(active);
        userRepository.save(existingUser);
    }

}
