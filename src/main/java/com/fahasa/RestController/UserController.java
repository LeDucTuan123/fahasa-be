package com.fahasa.RestController;

import com.fahasa.dao.UserDAO;
import com.fahasa.model.Favorite;
import com.fahasa.model.Order;
import com.fahasa.model.User;
import com.fahasa.reponsitory.UserRepository;
import com.fahasa.service.UserService;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
@CrossOrigin("*")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    // @GetMapping("/favorite/{id}")
    // public List<Favorite> getOrderSuccess(@PathVariable("id") Integer id) {
    //     return uDao.findFavoritesByUserId(id);
    // }

    @GetMapping
    public ResponseEntity<User> getUser() {
        // Lấy thông tin người dùng hiện tại từ Spring Security
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        // Trả về thông tin người dùng
        return ResponseEntity.ok(user);
    }
    
    @GetMapping("/getAll")
    public List<User> getAll() {
    	return userService.getAll();
    }
    


}
