package com.peczedavid.fogorvos.exception;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.time.ZonedDateTime;

@Getter
@Builder
public class ExceptionResponseBaseData {
    private String message;
    private HttpStatus httpStatus;
    private int httpStatusCode;
    private ZonedDateTime dateTime;
}
