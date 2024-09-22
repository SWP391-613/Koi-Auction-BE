package com.swp391.koibe.services.user;

import com.swp391.koibe.components.JwtTokenUtils;
import com.swp391.koibe.dtos.UserRegisterDTO;
import com.swp391.koibe.enums.ProviderName;
import com.swp391.koibe.exceptions.notfound.DataNotFoundException;
import com.swp391.koibe.exceptions.PermissionDeniedException;
import com.swp391.koibe.models.Role;
import com.swp391.koibe.models.SocialAccount;
import com.swp391.koibe.models.User;
import com.swp391.koibe.repositories.RoleRepository;
import com.swp391.koibe.repositories.SocialAccountRepository;
import com.swp391.koibe.repositories.UserRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

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

    @Override
    public User createUser(UserRegisterDTO userRegisterDTO) throws Exception {
        String email = userRegisterDTO.getEmail();
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isPresent()) {
            throw new DataIntegrityViolationException("Email already exists");
        }

        Role role = roleRepository.findById(userRegisterDTO.getRoleId())
                .orElseThrow(() -> new DataNotFoundException("Role not found"));

        if(role.getName().toUpperCase().equals(Role.MANAGER)){
            log.error("Cannot create manager account");
            throw new PermissionDeniedException("Cannot create manager account");
        }

        User newUser = User.builder()
                .firstName(userRegisterDTO.getFirstName())
                .lastName(userRegisterDTO.getLastName())
                .email(userRegisterDTO.getEmail())
                .password(userRegisterDTO.getPassword())
                .address(userRegisterDTO.getAddress())
                .dob(userRegisterDTO.getDateOfBirth())
                .avatarUrl("https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg")
                .googleAccountId(userRegisterDTO.getGoogleAccountId())
                .build();

        newUser.setRole(role);

        if (userRegisterDTO.getFacebookAccountId() == 0 && userRegisterDTO.getGoogleAccountId() == 0) {
            String password = userRegisterDTO.getPassword();
            String encodedPassword = passwordEncoder.encode(password);
            newUser.setPassword(encodedPassword);
        }
        return userRepository.save(newUser);
    }

    @Override
    public String login(String email, String password) throws Exception {
        Optional<User> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isEmpty()) {
            throw new DataNotFoundException("User not found");
        }
        User existingUser = optionalUser.get();
        if (existingUser.getGoogleAccountId() == 0) {
            if (!passwordEncoder.matches(password, existingUser.getPassword())) {
                throw new BadCredentialsException("Wrong email or password");
            }
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
            Role memberRole = roleRepository.findByName("MEMBER")
                    .orElseThrow(() -> new DataNotFoundException("Default MEMBER role not found"));

            User newUser = User.builder()
                    .firstName(name)
                    .email(email)
                    .googleAccountId(1)
                    .avatarUrl(avatarUrl)
                    .role(memberRole)
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

}
