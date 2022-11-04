package com.peczedavid.fogorvos;

import org.camunda.bpm.spring.boot.starter.annotation.EnableProcessApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// TODO: kérdés: service-ben exception, ami visszatér a controllerben egy responsebody-val (ProcessInstanceController.setVariable() -nél kéne)

@EnableProcessApplication
@SpringBootApplication
public class FogorvosApplication {

    public static void main(String[] args) {
        SpringApplication.run(FogorvosApplication.class, args);
    }

}
