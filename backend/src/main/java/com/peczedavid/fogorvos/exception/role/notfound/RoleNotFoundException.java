package com.peczedavid.fogorvos.exception.role.notfound;

import lombok.Getter;

@Getter
public class RoleNotFoundException extends RuntimeException {
    private final String roleName;

    public RoleNotFoundException(String message, String roleName) {
        super(message);
        this.roleName = roleName;
    }

}
