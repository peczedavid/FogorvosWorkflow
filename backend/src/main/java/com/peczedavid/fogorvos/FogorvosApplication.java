package com.peczedavid.fogorvos;

import org.camunda.bpm.spring.boot.starter.annotation.EnableProcessApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// TODO: válaszok magyarul

@EnableProcessApplication
@SpringBootApplication
public class FogorvosApplication {

    public static void main(String[] args) {
        SpringApplication.run(FogorvosApplication.class, args);
    }

}
