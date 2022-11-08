package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.process.VariablePayload;
import com.peczedavid.fogorvos.service.ProcessInstanceService;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.exception.NullValueException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/api/process-instance")
public class ProcessInstanceController {

    Logger logger = LoggerFactory.getLogger(ProcessInstanceController.class);

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private ProcessInstanceService processInstanceService;

    @PostMapping("/new")
    public ResponseEntity<?> startCleanProcess() {
        var processInstance = processInstanceService.getCleanProcess();
        return new ResponseEntity<>(new MessageResponse(processInstance.getProcessInstanceId()), HttpStatus.OK);
    }

    @PostMapping("/{id}/variables/{varName}")
    public ResponseEntity<MessageResponse> setVariable(@PathVariable String id, @PathVariable String varName, @RequestBody VariablePayload variablePayload) {
        Object variable;
        try {
            if ((variable = runtimeService.getVariable(id, varName)) == null) {
                logger.warn("Variable '" + varName + "' not found");
                return new ResponseEntity<>(new MessageResponse("Variable '" + varName + "' not found"), HttpStatus.NOT_FOUND);
            }
        } catch (NullValueException e) {
            logger.info("Process instance '" + id + "' not found");
            return new ResponseEntity<>(new MessageResponse("Process instance '" + id + "' not found"), HttpStatus.NOT_FOUND);
        }
        runtimeService.setVariable(id, varName, variablePayload.getValue());
        if (!variable.equals(runtimeService.getVariable(id, varName))) {
            logger.info("Variable value changed.");
            return new ResponseEntity<>(new MessageResponse("Variable value changed."), HttpStatus.OK);
        } else {
            logger.warn("Couldn't change variable value for '" + varName + "'.");
            return new ResponseEntity<>(new MessageResponse("Couldn't change variable value for '" + varName + "'."), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
