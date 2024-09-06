package com.swp391_09.Koi_BE.configs;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "unsplash.api")
@Getter
public class UnsplashConfig {
    private String root;
    private String clientId;
}

