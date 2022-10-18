package com.peczedavid.fogorvos.model;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.springframework.stereotype.Component;

@Component
public class Szamlazas implements JavaDelegate {
    @Override
    public void execute(DelegateExecution delegateExecution) throws Exception {
        System.out.println("Szamlazok");
    }
}
