package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/task")
public class TaskController {
    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    @GetMapping("/{id}")
    public ResponseEntity<?> getTask(@PathVariable String id) {
        Task task = taskService.createTaskQuery().taskId(id).list().get(0);

        List<VariableInstanceDto> taskVariables = runtimeService
                .createVariableInstanceQuery()
                .processInstanceIdIn(task.getProcessInstanceId())
                .list()
                .stream()
                .map(VariableInstanceDto::fromVariableInstance)
                .collect(Collectors.toList());

        TaskPayload taskPayload = TaskPayload.fromTask(task, taskVariables);
        return new ResponseEntity<>(taskPayload, HttpStatus.OK);
    }

    @PostMapping("/{id}/complete")
    public ResponseEntity<?> completeTask(@PathVariable String id) {
        taskService.complete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
