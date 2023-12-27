package com.fahasa.model;

import lombok.Data;

@Data
public class ChangeEmailRequest {
    private String email;
    private String newEmail;
    private String otp;
}
