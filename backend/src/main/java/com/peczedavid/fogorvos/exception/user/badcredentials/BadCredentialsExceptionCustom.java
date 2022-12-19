package com.peczedavid.fogorvos.exception.user.badcredentials;

public class BadCredentialsExceptionCustom extends RuntimeException {
    public BadCredentialsExceptionCustom(String message) {
        super(message);
    }
}
