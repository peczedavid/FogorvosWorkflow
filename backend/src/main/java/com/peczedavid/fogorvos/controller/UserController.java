package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.network.LoginRequest;
import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.network.RegisterRequest;
import com.peczedavid.fogorvos.model.network.UserData;
import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<List<UserData>> getUsers() {
        return userService.getUsers();
    }

    @GetMapping("/{id}/task")
    public ResponseEntity<List<TaskPayload>> getTasks(@PathVariable String id) {
        return userService.getTasks(id);
    }

    @GetMapping("/check")
    public ResponseEntity<UserData> checkUser(HttpServletRequest request) {
        return userService.checkUser(request);
    }

    @PostMapping("/logout")
    public ResponseEntity<MessageResponse> logout(HttpServletRequest request, HttpServletResponse response) {
        return userService.logout(request, response);
    }

    @PostMapping("/login")
    public ResponseEntity<UserData> login(@RequestBody LoginRequest loginRequest, HttpServletResponse response) {
        return userService.login(loginRequest, response);
    }

    @PostMapping("/register")
    public ResponseEntity<UserData> register(@RequestBody RegisterRequest registerRequest) {
        return userService.register(registerRequest);
    }
}
