package com.peczedavid.fogorvos.exception.task;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

import java.time.ZonedDateTime;

@Getter
@Setter
@Builder
public class TaskNotFoundExceptionResponse {
    private String taskId;
    private String message;
    private HttpStatus httpStatus;
    private int httpStatusCode;
    private ZonedDateTime dateTime;
}
