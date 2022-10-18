package com.peczedavid.fogorvos.controller;

import org.camunda.bpm.engine.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/task")
public class TaskController {
    @Autowired
    private TaskService taskService;

    @PostMapping("/{id}/complete")
    public ResponseEntity<?> completeTask(@PathVariable String id) {
        taskService.complete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
