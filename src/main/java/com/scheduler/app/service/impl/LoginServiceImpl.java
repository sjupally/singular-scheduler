package com.scheduler.app.service.impl;

import com.scheduler.app.dao.UserDao;
import com.scheduler.app.form.LoginForm;
import com.scheduler.app.model.User;
import com.scheduler.app.service.LoginService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LoginServiceImpl implements LoginService {

	@Autowired
	private UserDao userDao;

	@Override
	public boolean validateLogin(LoginForm loginForm) {
		boolean status = false;
		if (null != loginForm && null != loginForm.getUsername() && null != loginForm.getPassword()) {
			User user = userDao.getUserById(loginForm.getUsername());
			if (null != user && loginForm.getPassword().equals(user.getPassword())) {
				status = true;
			}
		}
		return status;
	}
}
