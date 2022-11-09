package com.peczedavid.fogorvos.model.network;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CheckResponse {

    private UserData userData;
    private boolean loggedId;

}
