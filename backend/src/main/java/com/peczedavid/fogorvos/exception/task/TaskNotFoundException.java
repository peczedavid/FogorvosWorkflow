package com.peczedavid.fogorvos.exception.task;

import lombok.Getter;

@Getter
public class TaskNotFoundException extends RuntimeException {
    private final String taskId;

    public TaskNotFoundException(String message, String taskId) {
        super(message);
        this.taskId = taskId;
    }
}
