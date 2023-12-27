package com.fahasa.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.fahasa.model.User;


public interface UserService {

    UserDetailsService userDetailsService();
    
    List<User> getUsers();
    
//    User updateUser(User user, Integer id);
    
    User getUserById(Integer id);
    
    void deleteUser(Integer id);
    
    User updateUserRole(User user, Integer id);

	List<User> getAll();

}
