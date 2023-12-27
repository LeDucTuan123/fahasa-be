package com.fahasa.exception;

public class UserAlreadyExitsException extends RuntimeException {
	public UserAlreadyExitsException(String message) {
		super(message);
	}
}
