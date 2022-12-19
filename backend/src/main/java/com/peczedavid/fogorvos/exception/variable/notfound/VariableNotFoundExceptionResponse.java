package com.peczedavid.fogorvos.exception.variable.notfound;

import com.peczedavid.fogorvos.exception.ExceptionResponseBase;
import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import lombok.Getter;

@Getter
public class VariableNotFoundExceptionResponse extends ExceptionResponseBase {
    private final String variableName;

    public VariableNotFoundExceptionResponse(String variableName, ExceptionResponseBaseData baseData) {
        super(baseData);
        this.variableName = variableName;
    }
}
