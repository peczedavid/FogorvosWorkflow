package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.service.TaskServiceCustom;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/api/task")
public class TaskController {
    private final TaskServiceCustom taskServiceCustom;

    public TaskController(TaskServiceCustom taskServiceCustom) {
        this.taskServiceCustom = taskServiceCustom;
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getTask(@PathVariable String id) {
        return taskServiceCustom.getTask(id);
    }

    @PostMapping("/{id}/complete")
    public ResponseEntity<?> completeTask(@PathVariable String id) {
        return taskServiceCustom.complete(id);
    }
}
