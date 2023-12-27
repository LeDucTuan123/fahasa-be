package com.fahasa.RestController;

import com.fahasa.dao.MessageResponse;
import com.fahasa.model.OtpDetails;
import com.fahasa.model.ResetPasswordRequest;
import com.fahasa.model.User;
import com.fahasa.reponsitory.OtpDetailsRepository;
import com.fahasa.reponsitory.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/v1/user/reset-password")
@RequiredArgsConstructor
public class ResetPasswordController {

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private OtpDetailsRepository otpDetailsRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/request")
    public ResponseEntity<MessageResponse> requestResetPassword(@RequestBody ResetPasswordRequest request) {
        Optional<User> optionalUser = userRepository.findByEmail(request.getEmail());
        if (optionalUser.isPresent()) {
            otpDetailsRepository.deleteByEmail(request.getEmail());

            String otp = generateRandomOtp();
            LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(2);

            saveOtpDetails(request.getEmail(), otp, expiryTime);
            sendOtpByEmail(request.getEmail(), otp);
            return ResponseEntity.ok(new MessageResponse(true, "Mã OTP đã được gửi đến email của bạn"));
        } else {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Email không tồn tại"));
        }
    }

    @PostMapping("/validate")
    public ResponseEntity<MessageResponse> validateOtp(@RequestBody ResetPasswordRequest request) {
        LocalDateTime currentTime = LocalDateTime.now();
        List<OtpDetails> validOtps = otpDetailsRepository.findByEmailAndOtpAndExpiryTimeAfter(request.getEmail(), request.getOtp(), currentTime);
        if (validOtps.isEmpty()) {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Mã OTP không hợp lệ"));
        } else {
            OtpDetails otpDetails = validOtps.get(0);
            LocalDateTime expiryTime = otpDetails.getExpiryTime();

            if (currentTime.isAfter(expiryTime)) {
                // Nếu thời gian hiện tại đã sau thời gian hết hạn của OTP, thông báo rằng OTP đã hết hạn
                return ResponseEntity.badRequest().body(new MessageResponse(false, "Mã OTP đã hết hạn"));
            } else {
                // Nếu thời gian hiện tại chưa sau thời gian hết hạn của OTP, thông báo rằng mã OTP hợp lệ
                return ResponseEntity.ok(new MessageResponse(true, "Mã OTP hợp lệ"));
            }
        }
    }

    @PostMapping("/update-password")
    public ResponseEntity<String> updatePassword(@RequestBody ResetPasswordRequest request) {
        Optional<User> optionalUser = userRepository.findByEmail(request.getEmail());

        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setPassword(passwordEncoder.encode(request.getNewPassword()));
            userRepository.save(user);
            // Xóa thông tin về OTP liên quan đến người dùng đã cập nhật mật khẩu mới
            otpDetailsRepository.deleteByEmail(request.getEmail());
            return ResponseEntity.ok("Mật khẩu đã được cập nhật thành công");
        } else {
            return ResponseEntity.badRequest().body("Email không tồn tại");
        }
    }

    private void saveOtpDetails(String email, String otp, LocalDateTime expiryTime) {
        OtpDetails otpDetails = new OtpDetails();
        otpDetails.setEmail(email);
        otpDetails.setOtp(otp);
        otpDetails.setExpiryTime(expiryTime);
        otpDetailsRepository.save(otpDetails);
    }

    private void sendOtpByEmail(String email, String otp) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Reset mật khẩu");
        message.setText("Mã OTP của bạn là: " + otp);
        javaMailSender.send(message);
    }

    private String generateRandomOtp() {
        int length = 6;
        String charset = "0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new SecureRandom();

        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(charset.length());
            sb.append(charset.charAt(randomIndex));
        }

        return sb.toString();
    }
}
