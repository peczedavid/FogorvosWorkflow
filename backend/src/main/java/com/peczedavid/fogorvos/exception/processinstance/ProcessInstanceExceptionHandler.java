package com.peczedavid.fogorvos.exception.processinstance;

import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import com.peczedavid.fogorvos.exception.processinstance.notfound.ProcessInstanceNotFoundException;
import com.peczedavid.fogorvos.exception.processinstance.notfound.ProcessInstanceNotFoundExceptionResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ProcessInstanceExceptionHandler {
    @ExceptionHandler(value = {ProcessInstanceNotFoundException.class})
    public ResponseEntity<ProcessInstanceNotFoundExceptionResponse> handleProcessInstanceNotFound(
            ProcessInstanceNotFoundException e
    ) {
        final HttpStatus notFound = HttpStatus.NOT_FOUND;
        final ExceptionResponseBaseData baseData = ExceptionResponseBaseData.fromRuntimeException(e, notFound);
        final ProcessInstanceNotFoundExceptionResponse responseBody =
                new ProcessInstanceNotFoundExceptionResponse(e.getProcessInstanceId(), baseData);
        return new ResponseEntity<>(responseBody, notFound);
    }
}
