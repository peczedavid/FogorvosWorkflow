package com.peczedavid.fogorvos.model.network;

import com.peczedavid.fogorvos.model.db.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserData {

    private String id;
    private String username;
    private String role;

    public UserData(User user) {
        this.id = user.getId().toString();
        this.username = user.getName();
        this.role = user.getRole().getName();
    }

}
