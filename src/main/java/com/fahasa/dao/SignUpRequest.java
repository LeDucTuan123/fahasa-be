package com.fahasa.dao;

import lombok.Data;

@Data
public class SignUpRequest {

    private String email;

    private String phone;

    private String password;
}
