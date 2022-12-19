package com.peczedavid.fogorvos.exception.task;

import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import com.peczedavid.fogorvos.exception.task.notfound.TaskNotFoundException;
import com.peczedavid.fogorvos.exception.task.notfound.TaskNotFoundExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class TaskExceptionHandler {
    @ExceptionHandler(value = {TaskNotFoundException.class})
    public ResponseEntity<TaskNotFoundExceptionResponse> handleTaskNotFoundException(TaskNotFoundException e) {
        final HttpStatus notFound = HttpStatus.NOT_FOUND;
        final ExceptionResponseBaseData baseData = ExceptionResponseBaseData.fromRuntimeException(e, notFound);
        final TaskNotFoundExceptionResponse responseBody = new TaskNotFoundExceptionResponse(e.getTaskId(), baseData);
        return new ResponseEntity<>(responseBody, notFound);
    }
}
