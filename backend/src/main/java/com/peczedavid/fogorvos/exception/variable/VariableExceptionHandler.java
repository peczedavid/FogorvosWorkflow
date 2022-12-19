package com.peczedavid.fogorvos.exception.variable;

import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import com.peczedavid.fogorvos.exception.variable.notfound.VariableNotFoundException;
import com.peczedavid.fogorvos.exception.variable.notfound.VariableNotFoundExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class VariableExceptionHandler {
    @ExceptionHandler(value = {VariableNotFoundException.class})
    public ResponseEntity<VariableNotFoundExceptionResponse> handleVariableNotFoundException(VariableNotFoundException e) {
        final HttpStatus notFound = HttpStatus.NOT_FOUND;
        final ExceptionResponseBaseData baseData = ExceptionResponseBaseData.fromRuntimeException(e, notFound);
        final VariableNotFoundExceptionResponse responseBody = new VariableNotFoundExceptionResponse(e.getVariableName(), baseData);
        return new ResponseEntity<>(responseBody, notFound);
    }
}
