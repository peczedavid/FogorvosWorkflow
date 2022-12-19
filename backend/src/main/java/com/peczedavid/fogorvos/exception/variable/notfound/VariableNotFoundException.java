package com.peczedavid.fogorvos.exception.variable.notfound;

import lombok.Getter;

@Getter
public class VariableNotFoundException extends RuntimeException {
    private final String variableName;

    public VariableNotFoundException(String message, String variableName) {
        super(message);
        this.variableName = variableName;
    }
}
