package com.swp391.koibe;

import com.swp391.koibe.utils.WebUtils;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.retry.annotation.EnableRetry;
import java.util.TimeZone;

@SpringBootApplication
@EnableCaching
@EnableRetry
//@EnableJpaRepositories(basePackages = "com.swp391.koibe.repositories")
public class App {

    public static void main(String[] args) {
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
        SpringApplication.run(App.class, args);
        WebUtils.openHomePage("http://localhost:8080/swagger-ui/index.html");
    }
}
