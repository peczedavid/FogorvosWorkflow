package com.peczedavid.fogorvos.exception;

import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.time.ZoneId;
import java.time.ZonedDateTime;

@Getter
@Builder
public class ExceptionResponseBaseData {
    private String message;
    private HttpStatus httpStatus;
    private int httpStatusCode;
    private ZonedDateTime dateTime;

    public static ExceptionResponseBaseData fromRuntimeException(RuntimeException e, HttpStatus httpStatus) {
        return ExceptionResponseBaseData
                .builder()
                .message(e.getMessage())
                .httpStatus(httpStatus)
                .httpStatusCode(httpStatus.value())
                .dateTime(ZonedDateTime.now(ZoneId.of("Z")))
                .build();
    }
}
