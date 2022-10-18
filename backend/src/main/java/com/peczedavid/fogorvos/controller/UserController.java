package com.peczedavid.fogorvos.controller;

import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.task.TaskDto;
import org.camunda.bpm.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private TaskService taskService;

    @GetMapping("/{id}/task")
    public ResponseEntity<?> getTasks(@PathVariable String id) {
        List<TaskDto> taskDtos = new ArrayList<>();
        List<Task> tasks = taskService.createTaskQuery().list();

        for (Task task : tasks) {
            if (task.getAssignee().equals(id)) {
                TaskDto taskDto = TaskDto.fromEntity(task);
                taskDtos.add(taskDto);
            }
        }

        return new ResponseEntity<>(taskDtos, HttpStatus.OK);
    }

}
