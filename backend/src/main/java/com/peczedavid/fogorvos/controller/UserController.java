package com.peczedavid.fogorvos.controller;

import com.peczedavid.fogorvos.model.network.CheckResponse;
import com.peczedavid.fogorvos.model.network.LoginRequest;
import com.peczedavid.fogorvos.model.network.MessageResponse;
import com.peczedavid.fogorvos.model.network.UserData;
import com.peczedavid.fogorvos.model.task.generic.TaskPayload;
import com.peczedavid.fogorvos.security.JwtUtils;
import com.peczedavid.fogorvos.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@CrossOrigin(origins = {"http://localhost:4200"}, maxAge = 3600, allowCredentials = "true")
@Controller
@RequestMapping("/api/user")
public class UserController {

    Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private JwtUtils jwtUtils;

    @GetMapping("/{id}/task")
    public ResponseEntity<?> getTasks(@PathVariable String id) {
        List<TaskPayload> taskPayloads = userService.getTasks(id);
        return new ResponseEntity<>(taskPayloads, HttpStatus.OK);
    }

    @GetMapping("/check")
    public ResponseEntity<CheckResponse> checkUser(HttpServletRequest request) {
        String jwt = jwtUtils.getJwtFromRequest(request);
        if (jwt == null) {
            CheckResponse checkResponse = new CheckResponse(null, false);
            return ResponseEntity.ok(checkResponse);
        }
        UserData userData = new UserData(jwtUtils.getUsername(jwt));
        CheckResponse checkResponse = new CheckResponse(userData, true);
        return ResponseEntity.ok(checkResponse);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpServletRequest request, HttpServletResponse response) {
        String jwt = jwtUtils.getJwtFromRequest(request);
        if (jwt == null) {
            logger.warn("No one to log out.");
            MessageResponse messageResponse = new MessageResponse("No one to log out.");
            return new ResponseEntity<>(messageResponse, HttpStatus.NOT_FOUND);
        }
        Cookie cookie = jwtUtils.generateLogutCookie();
        response.addCookie(cookie);
        // TODO: not technically logged out, but the cookie dissapears from the browser(when the page is refreshed, but it will be invalid)
        logger.info("User '" + jwtUtils.getUsername(jwt) + "' logged out.");
        MessageResponse messageResponse = new MessageResponse("User '" + jwtUtils.getUsername(jwt) + "' logged out.");
        return new ResponseEntity<>(messageResponse, HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(
            @RequestBody LoginRequest loginRequest,
            HttpServletResponse response) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword())
            );
        } catch (BadCredentialsException exception) {
            logger.error("Incorrect username or password!");
            return new ResponseEntity<>("Incorrect username or password!", HttpStatus.FORBIDDEN);
        }
        String userName = loginRequest.getUsername();
        UserDetails userDetails = userDetailsService.loadUserByUsername(userName);
        Cookie jwtCookie = jwtUtils.generaJwtCookie(userDetails);
        response.addCookie(jwtCookie);
        logger.info("User '" + userName + "' logged in.");
        UserData userData = new UserData(userName);
        return new ResponseEntity(userData, HttpStatus.OK);
    }
}
