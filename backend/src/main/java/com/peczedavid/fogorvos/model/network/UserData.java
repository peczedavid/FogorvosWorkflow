package com.peczedavid.fogorvos.model.network;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserData {

    // TODO: database id(will be the user variable in Camunda)
    private String username;

}
