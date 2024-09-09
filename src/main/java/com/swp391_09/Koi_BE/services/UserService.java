package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.components.JwtTokenUtils;
import com.swp391_09.Koi_BE.dtos.UserRegisterDTO;
import com.swp391_09.Koi_BE.exceptions.DataNotFoundException;
import com.swp391_09.Koi_BE.exceptions.PermissionDeniedException;
import com.swp391_09.Koi_BE.models.Role;
import com.swp391_09.Koi_BE.models.User;
import com.swp391_09.Koi_BE.repositories.RoleRepository;
import com.swp391_09.Koi_BE.repositories.UserRepository;
import java.util.ArrayList;
import java.util.List;
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
            .fullName(userRegisterDTO.getFullName())
            .email(userRegisterDTO.getEmail())
            .password(userRegisterDTO.getPassword())
            .address(userRegisterDTO.getAddress())
            .dob(userRegisterDTO.getDateOfBirth())
            .facebookAccountId(userRegisterDTO.getFacebookAccountId())
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
        if (existingUser.getFacebookAccountId() == 0 && existingUser.getGoogleAccountId() == 0) {
            if (!passwordEncoder.matches(password, existingUser.getPassword())) {
                throw new BadCredentialsException("Wrong email or password");
            }
        }
        UsernamePasswordAuthenticationToken authenticationToken =
            new UsernamePasswordAuthenticationToken(email, password, existingUser.getAuthorities());
        authenticationManager.authenticate(authenticationToken);
        return jwtTokenUtils.generateToken(existingUser);
    }

}
