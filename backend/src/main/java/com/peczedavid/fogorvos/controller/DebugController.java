package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.MessageResponse;
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

import java.util.Random;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/debug")
public class DebugController {

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private TaskService taskService;

    @PostMapping("/start")
    public ResponseEntity<?> startTask() {
        Random random = new Random();
        ProcessInstanceWithVariables instance = switch (random.nextInt(3)) {
            case 0 -> testFogszabalyzoKell();
            case 1 -> testFogszabalyzoNemKell();
            case 2 -> testSzakorvosiNemKellFogszabalyzo();
            default -> null;
        };
        return new ResponseEntity<>(new MessageResponse(instance.getId()), HttpStatus.OK);
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
                .setVariable("elmarad", false)
                .executeWithVariablesInReturn();
    }

    private ProcessInstanceWithVariables testFogszabalyzoNemKell() {
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

    private ProcessInstanceWithVariables testSzakorvosiNemKellFogszabalyzo() {
        return runtimeService.createProcessInstanceByKey("Process_Fogorvos")
                .setVariable("beteg", "fogorvosdemo")
                .setVariable("recepcios", "fogorvosdemo")
                .setVariable("orvos", "fogorvosdemo")
                .setVariable("rontgenes", "fogorvosdemo")
                .setVariable("szakorvos", "fogorvosdemo")
                .setVariable("rontgen", true)
                .setVariable("szakorvosiVizsgalat", true)
                .setVariable("fogszabalyzo", false)
                .setVariable("elmarad", false)
                .executeWithVariablesInReturn();
    }

}
