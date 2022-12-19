package com.peczedavid.fogorvos.exception.task;

import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
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
        final HttpStatus notFound = HttpStatus.NOT_FOUND;

        final ExceptionResponseBaseData baseData = ExceptionResponseBaseData
                .builder()
                .message(e.getMessage())
                .httpStatus(notFound)
                .httpStatusCode(notFound.value())
                .dateTime(ZonedDateTime.now(ZoneId.of("Z")))
                .build();

        final TaskNotFoundExceptionResponse responseBody = new TaskNotFoundExceptionResponse(e.getTaskId(), baseData);

        return new ResponseEntity<>(responseBody, notFound);
    }
}
