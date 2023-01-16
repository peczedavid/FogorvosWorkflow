package com.peczedavid.fogorvos.exception.role;

import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import com.peczedavid.fogorvos.exception.role.notfound.RoleNotFoundException;
import com.peczedavid.fogorvos.exception.role.notfound.RoleNotFoundExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class RoleExceptionHandler {
    @ExceptionHandler(value = {RoleNotFoundException.class})
    public ResponseEntity<RoleNotFoundExceptionResponse> handleRoleNotFoundException(RoleNotFoundException e) {
        final HttpStatus notFound = HttpStatus.NOT_FOUND;
        final ExceptionResponseBaseData baseData = ExceptionResponseBaseData.fromRuntimeException(e, notFound);
        final RoleNotFoundExceptionResponse responseBody = new RoleNotFoundExceptionResponse(e.getRoleName(), baseData);
        return new ResponseEntity<>(responseBody, notFound);
    }

}