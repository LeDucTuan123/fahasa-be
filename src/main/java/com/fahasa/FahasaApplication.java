package com.fahasa;

import com.fahasa.model.Role;
import com.fahasa.model.User;
import com.fahasa.reponsitory.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class })
public class FahasaApplication implements CommandLineRunner {

	@Autowired
	private UserRepository userRepository;

	public static void main(String[] args) {
		SpringApplication.run(FahasaApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		User adminAccount = userRepository.findByRole(Role.ADMIN);
		
		if (adminAccount == null) {
			User user = new User();

			user.setEmail("admin@gmail.com");
			user.setPhone("0399950365");
			user.setRole(Role.ADMIN);
			user.setPassword(new BCryptPasswordEncoder().encode("1234"));
			userRepository.save(user);
		}
	}
}
