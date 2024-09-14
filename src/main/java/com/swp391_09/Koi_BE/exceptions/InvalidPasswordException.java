package com.swp391_09.Koi_BE.exceptions;

public class InvalidPasswordException extends Exception{
    public InvalidPasswordException(String message) {
        super(message);
    }
}