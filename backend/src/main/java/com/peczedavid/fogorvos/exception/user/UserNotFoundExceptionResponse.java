package com.peczedavid.fogorvos.exception.user;

import com.peczedavid.fogorvos.exception.ExceptionResponseBase;
import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import lombok.Getter;

@Getter
public class UserNotFoundExceptionResponse extends ExceptionResponseBase {
    private final String userId;

    public UserNotFoundExceptionResponse(String userId, ExceptionResponseBaseData data) {
        super(data);
        this.userId = userId;
    }
}

