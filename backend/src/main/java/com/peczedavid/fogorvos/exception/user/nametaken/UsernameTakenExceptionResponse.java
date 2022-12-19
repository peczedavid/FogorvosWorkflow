package com.peczedavid.fogorvos.exception.user.nametaken;

import com.peczedavid.fogorvos.exception.ExceptionResponseBase;
import com.peczedavid.fogorvos.exception.ExceptionResponseBaseData;
import lombok.Getter;

@Getter
public class UsernameTakenExceptionResponse extends ExceptionResponseBase {
    private final String username;

    public UsernameTakenExceptionResponse(String username, ExceptionResponseBaseData baseData) {
        super(baseData);
        this.username = username;
    }
}
