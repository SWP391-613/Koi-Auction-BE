package com.swp391.koibe.services;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import org.mockito.InjectMocks;
import com.swp391.koibe.dtos.UserRegisterDTO;
import com.swp391.koibe.models.User;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test")
@ExtendWith(MockitoExtension.class)
@Disabled
class UserServiceTest {

//    @InjectMocks
//    private UserService  userService;
//
//    @BeforeEach
//    void setUp() {
//        // This will inject dependencies and initialize userService
//        userService = new UserService();
//    }
//
//    @Test
//    void testCreateUser_Success() throws Exception {
//        // Arrange
//        UserRegisterDTO dto = new UserRegisterDTO();
//        dto.setFullName("Test User");
//        dto.setEmail("test@gmail.com");
//        dto.setPassword("password123");
//        dto.setAddress("123 Test Address");
//        dto.setRoleId(1L); // Assuming roleId is 1 for USER
//
//        // Act
//        User newUser = userService.createUser(dto);
//
//        // Assert
//        assertNotNull(newUser);
//        assertEquals("Test User", newUser.getFullName());
//        assertEquals("test@gmail.com", newUser.getEmail());
//        assertEquals("password123", newUser.getPassword());
//        assertEquals("USER", newUser.getRole().getName());
//    }
//
//    @Test
//    void testCreateUser_EmailAlreadyExists() {
//        // Arrange
//        UserRegisterDTO dto = new UserRegisterDTO();
//        dto.setFullName("Admin User");
//        dto.setEmail("admin@gmail.com");  // This email already exists in the generateTestUser() method.
//        dto.setPassword("password123");
//        dto.setRoleId(1L);
//
//        // Act & Assert
//        Exception exception = assertThrows(Exception.class, () -> {
//            userService.createUser(dto);
//        });
//
//        assertEquals("Email already exists", exception.getMessage());
//    }
//
//    @Test
//    void testLogin_Success() throws Exception {
//        // Act
//        String result = userService.login("user@gmail.com", "123456");
//
//        // Assert
//        assertEquals("Login success", result);
//    }
//
//    @Test
//    void testLogin_WrongCredentials() {
//        // Act & Assert
//        Exception exception = assertThrows(Exception.class, () -> {
//            userService.login("user@gmail.com", "wrongpassword");
//        });
//
//        assertEquals("Wrong email or password", exception.getMessage());
//    }
}
