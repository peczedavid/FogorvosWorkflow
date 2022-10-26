package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.runtime.VariableInstance;
import org.camunda.bpm.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    @GetMapping("/{id}/task")
    public ResponseEntity<?> getTasks(@PathVariable String id) {
        List<Task> tasks = taskService.createTaskQuery().list();
        List<TaskPayload> taskPayloads = new ArrayList<>(tasks.size());

        for (Task task : tasks) {
            if (task.getAssignee().equals(id)) {
                List<VariableInstanceDto> taskVariables = runtimeService
                        .createVariableInstanceQuery()
                        .processInstanceIdIn(task.getProcessInstanceId())
                        .list()
                        .stream()
                        .map(VariableInstanceDto::fromVariableInstance)
                        .collect(Collectors.toList());

                TaskPayload taskPayload = TaskPayload.fromTask(task, taskVariables);
                taskPayloads.add(taskPayload);
            }
        }

        return new ResponseEntity<>(taskPayloads, HttpStatus.OK);
    }

}
