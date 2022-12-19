package com.peczedavid.fogorvos.exception.role.notfound;

import com.peczedavid.fogorvos.exception.ExceptionResponseBase;
import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import lombok.Getter;

@Getter
public class RoleNotFoundExceptionResponse extends ExceptionResponseBase {
    private final String roleName;

    public RoleNotFoundExceptionResponse(String roleName, ExceptionResponseBaseData baseData) {
        super(baseData);
        this.roleName = roleName;
    }
}
