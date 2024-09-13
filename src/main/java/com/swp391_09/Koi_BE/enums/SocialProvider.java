package com.swp391_09.Koi_BE.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SocialProvider {

    GOOGLE("google"),
    FACEBOOK("facebook");

    private final String provider;

}
