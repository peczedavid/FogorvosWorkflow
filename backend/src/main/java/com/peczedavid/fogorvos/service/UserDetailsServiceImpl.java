package com.peczedavid.fogorvos.service;

import com.peczedavid.fogorvos.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    Logger logger = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private UserRepository userRepository;

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<com.peczedavid.fogorvos.model.db.User> user = userRepository.findByName(username);
        if (user.isEmpty()) {
            logger.error("User '" + username + "' not found!");
            throw new UsernameNotFoundException("User '" + username + "' not found!");
        }
        UserDetails userDetails = new org.springframework.security.core.userdetails.User(
                user.get().getName(),
                user.get().getPassword(),
                new ArrayList<>()
        );
        return userDetails;
    }
}
