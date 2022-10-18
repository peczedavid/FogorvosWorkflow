package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.DebugResponse;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@CrossOrigin(origins = { "http://localhost:4200" }, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/debug")
public class DebugController {

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private TaskService taskService;

    @PostMapping("/start")
    public ResponseEntity<?> startTask() {
        ProcessInstanceWithVariables instance = testFogszabalyzoKell();
        DebugResponse response = new DebugResponse(instance.getId());
        return new ResponseEntity<DebugResponse>(response, HttpStatus.OK);
    }

    private ProcessInstanceWithVariables testFogszabalyzoKell() {
        return runtimeService.createProcessInstanceByKey("Process_Fogorvos")
                .setVariable("beteg", "fogorvosdemo")
                .setVariable("recepcios", "fogorvosdemo")
                .setVariable("orvos", "fogorvosdemo")
                .setVariable("rontgenes", "fogorvosdemo")
                .setVariable("szakorvos", "fogorvosdemo")
                .setVariable("rontgen", true)
                .setVariable("szakorvosiVizsgalat", true)
                .setVariable("fogszabalyzo", true)
                .executeWithVariablesInReturn();
    }

    private void testFogszabalyzoNemKell() {
        ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey("Process_Fogorvos")
                .setVariable("beteg", "fogorvosdemo")
                .setVariable("recepcios", "fogorvosdemo")
                .setVariable("orvos", "fogorvosdemo")
                .setVariable("rontgenes", "fogorvosdemo")
                .setVariable("szakorvos", "fogorvosdemo")
                .setVariable("rontgen", false)
                .setVariable("szakorvosiVizsgalat", false)
                .setVariable("fogszabalyzo", false)
                .executeWithVariablesInReturn();
    }

    private void testSzakorvosiNemKellFogszabalyzo() {
        ProcessInstanceWithVariables instance = runtimeService.createProcessInstanceByKey("Process_Fogorvos")
                .setVariable("beteg", "fogorvosdemo")
                .setVariable("recepcios", "fogorvosdemo")
                .setVariable("orvos", "fogorvosdemo")
                .setVariable("rontgenes", "fogorvosdemo")
                .setVariable("szakorvos", "fogorvosdemo")
                .setVariable("rontgen", true)
                .setVariable("szakorvosiVizsgalat", true)
                .setVariable("fogszabalyzo", false)
                .executeWithVariablesInReturn();
    }

}
