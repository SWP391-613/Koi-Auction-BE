package com.swp391.koibe.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ProviderName {

    GOOGLE("GOOGLE"),
    FACEBOOK("FACEBOOK"),;

    private final String providerName;

}