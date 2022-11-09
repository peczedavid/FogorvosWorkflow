package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.process.VariablePayload;
import com.peczedavid.fogorvos.service.ProcessInstanceService;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/api/process-instance")
public class ProcessInstanceController {

    @Autowired
    private ProcessInstanceService processInstanceService;

    @PostMapping("/new")
    public ResponseEntity<?> startCleanProcess() {
        ProcessInstanceWithVariables processInstance = processInstanceService.getCleanProcess();
        return new ResponseEntity<>(new MessageResponse(processInstance.getProcessInstanceId()), HttpStatus.OK);
    }

    @PostMapping("/{id}/variables/{varName}")
    public ResponseEntity<MessageResponse> setVariable(
            @PathVariable String id, @PathVariable String varName, @RequestBody VariablePayload variablePayload) {
        return processInstanceService.setVariable(id, varName, variablePayload);
    }

}
