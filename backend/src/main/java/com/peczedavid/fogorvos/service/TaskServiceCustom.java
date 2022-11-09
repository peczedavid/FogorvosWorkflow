package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TaskServiceCustom {

    private static final Logger logger = LoggerFactory.getLogger(TaskServiceCustom.class);

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    public ResponseEntity<?> getTask(String id) {
        Task task = taskService.createTaskQuery().taskId(id).singleResult();
        if(task == null) {
            logger.error("Task " + id + " not found");
            return new ResponseEntity<>(new MessageResponse("Task " + id + " not found!"), HttpStatus.NOT_FOUND);
        }
        List<VariableInstanceDto> taskVariables = runtimeService
                .createVariableInstanceQuery()
                .processInstanceIdIn(task.getProcessInstanceId())
                .list()
                .stream()
                .map(VariableInstanceDto::fromVariableInstance)
                .collect(Collectors.toList());

        return new ResponseEntity<>(TaskPayload.fromTask(task, taskVariables), HttpStatus.OK);
    }

    public ResponseEntity<?> complete(String id) {
        taskService.complete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
