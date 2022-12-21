package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.FogorvosApplication;
import com.peczedavid.fogorvos.model.db.Role;
import org.junit.Assert;
import org.junit.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.ArrayList;
import java.util.List;

@ActiveProfiles("test")
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = FogorvosApplication.class)
@ExtendWith(SpringExtension.class)
public class RoleServiceTest {

    @Autowired
    private RoleService roleService;

    @Test
    public void test() {
        List<Role> roleList = new ArrayList<>();
        roleList.add(new Role(1L, "ROLE_ADMIN"));
        roleList.add(new Role(2L, "ROLE_USER"));
        ResponseEntity<List<Role>> response = new ResponseEntity<>(roleList, HttpStatus.OK);
        Mockito.when(roleService.getRoles()).thenReturn(response);
        ResponseEntity<List<Role>> testResponse = roleService.getRoles();
        Assert.assertEquals(response, testResponse);
    }
}
