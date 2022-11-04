package com.peczedavid.fogorvos.service;

import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProcessInstanceService {

    @Autowired
    private RuntimeService runtimeService;

    public ProcessInstanceWithVariables getCleanProcess() {
        return runtimeService.createProcessInstanceByKey("Process_Fogorvos")
                .setVariable("beteg", "fogorvosdemo")
                .setVariable("recepcios", "fogorvosdemo")
                .setVariable("orvos", "fogorvosdemo")
                .setVariable("rontgenes", "fogorvosdemo")
                .setVariable("szakorvos", "fogorvosdemo")
                .setVariable("rontgen", false)
                .setVariable("szakorvosiVizsgalat", false)
                .setVariable("fogszabalyzo", false)
                .setVariable("elmarad", false)
                .executeWithVariablesInReturn();
    }

}
