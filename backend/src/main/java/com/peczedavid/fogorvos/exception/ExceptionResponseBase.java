package com.peczedavid.fogorvos.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.time.ZonedDateTime;

@Getter
public abstract class ExceptionResponseBase {
    protected String message;
    protected HttpStatus httpStatus;
    protected int httpStatusCode;
    protected ZonedDateTime dateTime;

    protected ExceptionResponseBase(ExceptionResponseBaseData data) {
        this.message = data.getMessage();
        this.httpStatus = data.getHttpStatus();
        this.httpStatusCode = data.getHttpStatusCode();
        this.dateTime = data.getDateTime();
    }

}
