package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.exception.role.notfound.RoleNotFoundException;
import com.peczedavid.fogorvos.exception.user.badcredentials.BadCredentialsExceptionCustom;
import com.peczedavid.fogorvos.exception.user.nametaken.UsernameTakenException;
import com.peczedavid.fogorvos.exception.user.notfound.UserNotFoundException;
import com.peczedavid.fogorvos.model.db.Role;
import com.peczedavid.fogorvos.model.db.User;
import com.peczedavid.fogorvos.model.network.LoginRequest;
import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.network.RegisterRequest;
import com.peczedavid.fogorvos.model.network.UserData;
import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.repository.RoleRepository;
import com.peczedavid.fogorvos.repository.UserRepository;
import com.peczedavid.fogorvos.security.JwtUtils;
import com.peczedavid.fogorvos.security.UserDetailsImpl;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.rest.dto.runtime.VariableInstanceDto;
import org.camunda.bpm.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    private final TaskService taskService;
    private final RuntimeService runtimeService;
    private final JwtUtils jwtUtils;
    private final AuthenticationManager authenticationManager;
    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserService(
            TaskService taskService,
            RuntimeService runtimeService,
            JwtUtils jwtUtils,
            AuthenticationManager authenticationManager,
            UserDetailsService userDetailsService,
            PasswordEncoder passwordEncoder,
            UserRepository userRepository,
            RoleRepository roleRepository
    ) {
        this.taskService = taskService;
        this.runtimeService = runtimeService;
        this.jwtUtils = jwtUtils;
        this.authenticationManager = authenticationManager;
        this.userDetailsService = userDetailsService;
        this.passwordEncoder = passwordEncoder;
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public ResponseEntity<List<UserData>> getUsers() {
        List<UserData> users = userRepository
                .findAll()
                .stream()
                .map(UserData::new)
                .toList();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    public ResponseEntity<UserData> login(LoginRequest loginRequest, HttpServletResponse response) {
        try {
            final String username = loginRequest.getUsername();
            final String password = loginRequest.getPassword();
            authenticationManager
                    .authenticate(new UsernamePasswordAuthenticationToken(username, password));
            UserDetailsImpl userDetailsImpl = (UserDetailsImpl) userDetailsService.loadUserByUsername(username);
            Cookie jwtCookie = jwtUtils.generateJwtCookie(userDetailsImpl);
            response.addCookie(jwtCookie);
            User dbUser = userRepository.findByName(username).orElse(null);
            if (dbUser == null) {
                logger.error("Cannot find user with name " + username);
                throw new UserNotFoundException("Nem található a felhasználó", username);
            }
            logger.info("User '" + username + "' logged in.");
            UserData userData = new UserData(String.valueOf(userDetailsImpl.getId()), username, dbUser.getRole().getName());
            return new ResponseEntity<>(userData, HttpStatus.OK);
        } catch (BadCredentialsException exception) {
            logger.error("Incorrect username or password!");
            throw new BadCredentialsExceptionCustom("Hibás felhasználónév vagy jelszó");
        }
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
        UserData userData = new UserData(jwtUtils.getId(jwt), jwtUtils.getUsername(jwt), jwtUtils.getRole(jwt));
        return ResponseEntity.ok(userData);
    }

    public ResponseEntity<List<TaskPayload>> getTasks(String userId) {
        List<Task> tasks = taskService.createTaskQuery().taskAssignee(userId).list();
        List<TaskPayload> taskPayloads = new ArrayList<>(tasks.size());

        for (Task task : tasks) {
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
        return new ResponseEntity<>(taskPayloads, HttpStatus.OK);
    }

    public ResponseEntity<UserData> register(RegisterRequest registerRequest) {
        final String username = registerRequest.getUsername();
        final String password = passwordEncoder.encode(registerRequest.getPassword());
        Optional<User> dbUser = userRepository.findByName(username);
        if (dbUser.isPresent()) {
            logger.error("Username '" + username + "' is already taken");
            throw new UsernameTakenException("A felhasználónév foglalt", username);
        }
        final String role = registerRequest.getRole();
        Optional<Role> dbRole = roleRepository.findByName(role);
        if (dbRole.isEmpty()) {
            logger.error("Role '" + role + "' not found");
            throw new RoleNotFoundException("Szerepkör: '" + role + "' nem található", role);
        }
        User user = new User(username, password, dbRole.get());
        userRepository.save(user);
        logger.info("User '" + username + "' successfully registered");
        UserData userData = new UserData(String.valueOf(user.getId()), user.getName(), role);
        return new ResponseEntity<>(userData, HttpStatus.OK);
    }
}
