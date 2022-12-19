package com.peczedavid.fogorvos.exception.processinstance.notfound;

import lombok.Getter;

@Getter
public class ProcessInstanceNotFoundException extends RuntimeException {
    private final String processInstanceId;

    public ProcessInstanceNotFoundException(String message, String processInstanceId) {
        super(message);
        this.processInstanceId = processInstanceId;
    }
}
