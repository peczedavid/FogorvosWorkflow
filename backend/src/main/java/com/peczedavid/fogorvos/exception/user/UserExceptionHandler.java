package com.peczedavid.fogorvos.exception.user;

import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class UserExceptionHandler {
    @ExceptionHandler(value = {UserNotFoundException.class})
    public ResponseEntity<UserNotFoundExceptionResponse> handleUserNotFoundException(UserNotFoundException e) {
        final HttpStatus notFound = HttpStatus.NOT_FOUND;
        final ExceptionResponseBaseData baseData = ExceptionResponseBaseData.fromRuntimeException(e, notFound);
        final UserNotFoundExceptionResponse responseBody = new UserNotFoundExceptionResponse(e.getUserId(), baseData);
        return new ResponseEntity<>(responseBody, notFound);
    }
}
