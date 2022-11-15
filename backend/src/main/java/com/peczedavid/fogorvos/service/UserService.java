package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.model.db.User;
import com.peczedavid.fogorvos.model.network.LoginRequest;
import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.network.RegisterRequest;
import com.peczedavid.fogorvos.model.network.UserData;
import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.repository.UserRepository;
import com.peczedavid.fogorvos.security.JwtUtils;
import com.peczedavid.fogorvos.security.UserDetailsImpl;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private JwtUtils jwtUtils;
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    private ResponseEntity<?> tryLogin(String username, String password, HttpServletResponse response) {
        try {
            authenticationManager
                    .authenticate(new UsernamePasswordAuthenticationToken(username, password));
            UserDetailsImpl userDetailsImpl = (UserDetailsImpl) userDetailsService.loadUserByUsername(username);
            String userName = userDetailsImpl.getUsername();
            Cookie jwtCookie = jwtUtils.generaJwtCookie(userDetailsImpl);
            response.addCookie(jwtCookie);
            logger.info("User '" + userName + "' logged in.");
            UserData userData = new UserData(String.valueOf(userDetailsImpl.getId()), userName);
            return new ResponseEntity<>(userData, HttpStatus.OK);
        } catch (BadCredentialsException exception) {
            logger.error("Incorrect username or password!");
            MessageResponse messageResponse = new MessageResponse("Incorrect username or password!");
            return new ResponseEntity<>(messageResponse, HttpStatus.FORBIDDEN);
        }
    }

    public ResponseEntity<?> login(LoginRequest loginRequest, HttpServletResponse response) {
        return tryLogin(loginRequest.getUsername(), loginRequest.getPassword(), response);
    }

    public ResponseEntity<MessageResponse> logout(HttpServletRequest request, HttpServletResponse response) {
        String jwt = jwtUtils.getJwtFromRequest(request);
        if (jwt == null) {
            logger.warn("No one to log out.");
            MessageResponse messageResponse = new MessageResponse("No one to log out.");
            return new ResponseEntity<>(messageResponse, HttpStatus.NOT_FOUND);
        }
        Cookie cookie = jwtUtils.generateLogutCookie();
        response.addCookie(cookie);
        logger.info("User '" + jwtUtils.getUsername(jwt) + "' logged out.");
        MessageResponse messageResponse = new MessageResponse("User '" + jwtUtils.getUsername(jwt) + "' logged out.");
        return new ResponseEntity<>(messageResponse, HttpStatus.OK);
    }

    public ResponseEntity<UserData> checkUser(HttpServletRequest request) {
        String jwt = jwtUtils.getJwtFromRequest(request);
        if (jwt == null) {
            return ResponseEntity.ok(null);
        }
        UserData userData = new UserData(jwtUtils.getId(jwt), jwtUtils.getUsername(jwt));
        return ResponseEntity.ok(userData);
    }

    public ResponseEntity<List<TaskPayload>> getTasks(String userId) {
        List<Task> tasks = taskService.createTaskQuery().list();
        List<TaskPayload> taskPayloads = new ArrayList<>(tasks.size());

        for (Task task : tasks) {
            if (task.getAssignee().equals(userId)) {
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

    public ResponseEntity<?> register(RegisterRequest registerRequest, HttpServletResponse response) {
        final String username = registerRequest.getUsername();
        final String password = passwordEncoder.encode(registerRequest.getPassword());
        Optional<User> dbUser = userRepository.findByName(username);
        if (dbUser.isPresent()) {
            logger.warn("Username '" + username + "' is already taken");
            return new ResponseEntity<>(new MessageResponse("Username '" + username + "' is already taken."), HttpStatus.BAD_REQUEST);
        }
        User user = new User(username, password);
        userRepository.save(user);
        logger.info("User '" + username + "' successfully registered");

        return tryLogin(username, registerRequest.getPassword(), response);
    }
}
