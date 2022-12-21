package com.peczedavid.fogorvos.service;

import org.mockito.Mockito;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;

@Profile("test")
@Configuration
public class RoleServiceTestConfiguration {
    @Bean
    @Primary
    public RoleService roleService() {
        return Mockito.mock(RoleService.class);
    }
}
