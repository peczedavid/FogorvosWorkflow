package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.model.db.Role;
import com.peczedavid.fogorvos.repository.RoleRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService {

    private final RoleRepository roleRepository;

    public RoleService(
            RoleRepository roleRepository
    ) {
        this.roleRepository = roleRepository;
    }

    public ResponseEntity<List<Role>> getRoles() {
        return new ResponseEntity<>(roleRepository.findAll(), HttpStatus.OK);
    }

}
