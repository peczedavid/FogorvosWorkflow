package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TaskServiceCustom {

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    public ResponseEntity<TaskPayload> getTask(String id) {
        Task task = taskService.createTaskQuery().taskId(id).list().get(0);
        // TODO: task not found
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
