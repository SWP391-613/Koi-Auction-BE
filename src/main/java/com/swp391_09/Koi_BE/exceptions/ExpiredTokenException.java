package com.swp391_09.Koi_BE.exceptions;

public class ExpiredTokenException extends Exception{
    public ExpiredTokenException(String message) {
        super(message);
    }
}