package com.scheduler.app.dao.impl;

import com.scheduler.app.dao.UserDao;
import com.scheduler.app.model.User;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private SessionFactory sessionFactory;

	private static Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);

	@Override
	public User getUserById(String userId) {
		User user = null;
		Session session = sessionFactory.openSession();
		try {
			user = (User) session.createCriteria(User.class).add(Restrictions.eq("userId", userId)).uniqueResult();

		} catch (Exception e) {
			logger.error("Exception occurs while getting the User object by userId: " + e.getMessage());
		} finally {
			session.close();
		}
		return user;
	}

}
