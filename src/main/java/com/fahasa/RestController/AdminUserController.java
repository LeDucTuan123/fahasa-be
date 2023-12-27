package com.fahasa.RestController;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.model.User;
import com.fahasa.service.UserService;

import lombok.RequiredArgsConstructor;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/admin/users")
@RequiredArgsConstructor
public class AdminUserController {
	private final UserService userService;
	
	@GetMapping
    public ResponseEntity<List<User>> getUsers(){
		return new ResponseEntity<>(userService.getUsers(), HttpStatus.FOUND);
	}
    
    @PutMapping("/update/{id}")
    public User updateUser(@RequestBody User user,@PathVariable Integer id) {
    	return userService.updateUserRole(user, id);
    }
    
    @DeleteMapping("/delete/{id}")
    public void deleteUser(@PathVariable Integer id) {
    	userService.deleteUser(id);
    }
    
    @GetMapping("/user/{id}")
    public User getUserById(@PathVariable Integer id) {
    	return userService.getUserById(id);
    }
}
