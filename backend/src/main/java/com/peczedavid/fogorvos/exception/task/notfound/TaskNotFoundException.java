package com.peczedavid.fogorvos.exception.task.notfound;

import lombok.Getter;

@Getter
public class TaskNotFoundException extends RuntimeException {
    private final String taskId;

    public TaskNotFoundException(String message, String taskId) {
        super(message);
        this.taskId = taskId;
    }
}
