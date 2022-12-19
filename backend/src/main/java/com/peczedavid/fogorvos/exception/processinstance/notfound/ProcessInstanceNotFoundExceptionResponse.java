package com.peczedavid.fogorvos.exception.processinstance.notfound;

import com.peczedavid.fogorvos.exception.ExceptionResponseBase;
import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import lombok.Getter;

@Getter
public class ProcessInstanceNotFoundExceptionResponse extends ExceptionResponseBase {
    private final String processInstanceId;

    public ProcessInstanceNotFoundExceptionResponse(String processInstanceId, ExceptionResponseBaseData baseData) {
        super(baseData);
        this.processInstanceId = processInstanceId;
    }
}
