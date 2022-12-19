package com.peczedavid.fogorvos.exception.task;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.time.ZoneId;
import java.time.ZonedDateTime;

@ControllerAdvice
public class TaskExceptionHandler {
    @ExceptionHandler(value = {TaskNotFoundException.class})
    public ResponseEntity<TaskNotFoundExceptionResponse> handleTaskNotFoundException(TaskNotFoundException e) {
        HttpStatus notFound = HttpStatus.NOT_FOUND;
        TaskNotFoundExceptionResponse responseBody
                = TaskNotFoundExceptionResponse
                .builder()
                .taskId(e.getTaskId())
                .message(e.getMessage())
                .dateTime(ZonedDateTime.now(ZoneId.of("Z")))
                .httpStatus(notFound)
                .httpStatusCode(HttpStatus.NOT_FOUND.value())
                .build();
        return new ResponseEntity<>(responseBody, notFound);
    }
}
