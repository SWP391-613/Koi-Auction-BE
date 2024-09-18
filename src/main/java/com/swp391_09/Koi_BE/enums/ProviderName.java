package com.swp391_09.Koi_BE.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ProviderName {

    GOOGLE("GOOGLE"),
    FACEBOOK("FACEBOOK"),;

    private final String providerName;

}
