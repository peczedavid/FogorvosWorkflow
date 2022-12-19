package com.peczedavid.fogorvos.exception.user;

import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import com.peczedavid.fogorvos.exception.user.badcredentials.BadCredentialsExceptionCustom;
import com.peczedavid.fogorvos.exception.user.badcredentials.BadCredentialsExceptionCustomResponse;
import com.peczedavid.fogorvos.exception.user.nametaken.UsernameTakenException;
import com.peczedavid.fogorvos.exception.user.nametaken.UsernameTakenExceptionResponse;
import com.peczedavid.fogorvos.exception.user.notfound.UserNotFoundException;
import com.peczedavid.fogorvos.exception.user.notfound.UserNotFoundExceptionResponse;
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

    @ExceptionHandler(value = {UsernameTakenException.class})
    public ResponseEntity<UsernameTakenExceptionResponse> handleUsernameTakenException(UsernameTakenException e) {
        final HttpStatus badRequest = HttpStatus.BAD_REQUEST;
        final ExceptionResponseBaseData baseData = ExceptionResponseBaseData.fromRuntimeException(e, badRequest);
        final UsernameTakenExceptionResponse responseBody = new UsernameTakenExceptionResponse(e.getUsername(), baseData);
        return new ResponseEntity<>(responseBody, badRequest);
    }

    @ExceptionHandler(value = {BadCredentialsExceptionCustom.class})
    public ResponseEntity<BadCredentialsExceptionCustomResponse> handleBadCredentialsException(BadCredentialsExceptionCustom e) {
        final HttpStatus badRequest = HttpStatus.BAD_REQUEST;
        final ExceptionResponseBaseData baseData = ExceptionResponseBaseData.fromRuntimeException(e, badRequest);
        final BadCredentialsExceptionCustomResponse responseBody = new BadCredentialsExceptionCustomResponse(baseData);
        return new ResponseEntity<>(responseBody, badRequest);
    }
}
