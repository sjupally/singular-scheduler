package com.scheduler.app.form;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotEmpty;

public class LoginForm implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8688814949102302879L;

	@NotEmpty
	private String username;
	@NotEmpty
	private String password;

	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @param username
	 *            the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
}
