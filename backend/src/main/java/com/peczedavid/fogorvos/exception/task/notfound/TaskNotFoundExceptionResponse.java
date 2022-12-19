package com.peczedavid.fogorvos.exception.task.notfound;

import com.peczedavid.fogorvos.exception.ExceptionResponseBase;
import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import lombok.Getter;

@Getter
public class TaskNotFoundExceptionResponse extends ExceptionResponseBase {
    private final String taskId;

    public TaskNotFoundExceptionResponse(String taskId, ExceptionResponseBaseData baseData) {
        super(baseData);
        this.taskId = taskId;
    }
}
