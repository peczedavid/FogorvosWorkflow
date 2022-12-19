package com.peczedavid.fogorvos.exception.user.nametaken;

import lombok.Getter;

@Getter
public class UsernameTakenException extends RuntimeException {
    private final String username;

    public UsernameTakenException(String message, String username) {
        super(message);
        this.username = username;
    }
}
