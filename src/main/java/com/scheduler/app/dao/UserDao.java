package com.scheduler.app.dao;

import com.scheduler.app.model.User;

public interface UserDao {

	User getUserById(String username);
}
