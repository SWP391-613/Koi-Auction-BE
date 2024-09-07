package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.dtos.UserRegisterDTO;
import com.swp391_09.Koi_BE.models.Role;
import com.swp391_09.Koi_BE.models.User;
import java.util.ArrayList;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class UserService implements IUserService{

    List<User> userList = new ArrayList<>();

    public UserService(){
        userList = generateTestUser();
    }

    @Override
    public User createUser(UserRegisterDTO userRegisterDTO) throws Exception {
        String email = userRegisterDTO.getEmail();

        for (User user : userList) {
            if (user.getEmail().equals(email)) {
                log.error("Email already exists");
                throw new Exception("Email already exists");
            }
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

        newUser.setRole(new Role(userRegisterDTO.getRoleId(), "USER"));

        log.info("New user registered successfully");

        return newUser;
    }

    @Override
    public String login(String email, String password) throws Exception {
        for (User user : userList) {
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                log.info("Login success");
                return "Login success";
            }
        }
        log.error("Wrong email or password");
        throw new Exception("Wrong email or password");
    }

    private List<User> generateTestUser() {
        List<User> userList = new ArrayList<>();

        User user = User.builder()
            .email("user@gmail.com")
            .password("123456")
            .build();

        User admin = User.builder()
            .email("admin@gmail.com")
            .password("123456")
            .build();

        User koiBreeder = User.builder()
            .email("koi@gmail.com")
            .password("123456")
            .build();

        userList.add(user);
        userList.add(admin);
        userList.add(koiBreeder);

        return userList;
    }

}
