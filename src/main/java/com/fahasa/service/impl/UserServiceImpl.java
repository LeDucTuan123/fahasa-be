package com.fahasa.service.impl;

import com.fahasa.dao.UserDAO;
import com.fahasa.exception.UserNotFoundException;
import com.fahasa.model.User;
import com.fahasa.reponsitory.UserRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.stereotype.Service;

import com.fahasa.service.UserService;
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserDAO dao;

    private final UserRepository userRepository;

    @Override
    public UserDetailsService userDetailsService() {
        return new UserDetailsService() {
            @Override
            public UserDetails loadUserByUsername(String username) {
                return userRepository.findByEmail(username)
                        .orElseThrow(() -> new UsernameNotFoundException("User not found"));
            }
        };
    }

    
	@Override
	public List<User> getUsers() {
		return userRepository.findAll();
		
	}


//	@Override
//	public User updateUser(User user, Integer id) {
//		
//		return userRepository.findById(id).map(u -> {
//			u.setAuth(user.getAuth());
//			return userRepository.save(u);
//		}).orElseThrow(() -> new UserNotFoundException("Xin lỗi, người dùng này không được tìm thấy"));
//	}
	
	@Override
	public User updateUserRole(User user, Integer id) {
	    return userRepository.findById(id).map(u -> {
	        u.setRole(user.getRole());
	        return userRepository.save(u);
	    }).orElseThrow(() -> new UserNotFoundException("Xin lỗi, người dùng này không được tìm thấy"));
	}
	

	@Override
	public User getUserById(Integer id) {
		
		return userRepository.findById(id)
				.orElseThrow(() -> new UserNotFoundException("Xin lỗi,không tồn tại người dùng với id này" + id));
	}

	@Override
	public void deleteUser(Integer id) {
		if(!userRepository.existsById(id)) {
			throw new UserNotFoundException("Xin lỗi, người dùng không tồn tại");
		}
		
	}
	
	private boolean userAlreadyExits(String email) {
		return userRepository.findByEmail(email).isPresent();
	}


	@Override
	public List<User> getAll() {
		return dao.findAll();
	}

    
   

}
