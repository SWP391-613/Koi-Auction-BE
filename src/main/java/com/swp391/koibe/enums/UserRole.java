package com.swp391.koibe.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserRole {

    MEMBER("MEMBER"),
    STAFF("STAFF"),
    BREEDER("BREEDER"),
    MANAGER("MANAGER");

    private final String role;

}
