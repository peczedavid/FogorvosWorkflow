package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.service.TaskServiceCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/task")
public class TaskController {
    @Autowired
    private TaskServiceCustom taskServiceCustom;

    @GetMapping("/{id}")
    public ResponseEntity<?> getTask(@PathVariable String id) {
        TaskPayload taskPayload = taskServiceCustom.getTask(id);
        return new ResponseEntity<>(taskPayload, HttpStatus.OK);
    }

    @PostMapping("/{id}/complete")
    public ResponseEntity<?> completeTask(@PathVariable String id) {
        taskServiceCustom.complete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
