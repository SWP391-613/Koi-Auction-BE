package com.swp391.koibe.exceptions;

public class PhoneAlreadyUsedException extends RuntimeException {

    public PhoneAlreadyUsedException(String message) {
        super(message);
    }
}
