package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.models.User;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class UserService implements IUserService{

    @Override
    public String login(String email, String password) throws Exception {
        List<User> userList = generateTestUser();
        for (User user : userList) {
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                return "Login success";
            }
        }
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
