package com.swp391_09.Koi_BE.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ProviderName {

    GOOGLE("google"),
    FACEBOOK("facebook");

    private final String providerName;

}
