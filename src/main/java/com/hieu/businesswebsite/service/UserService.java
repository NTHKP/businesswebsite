package com.hieu.businesswebsite.service;

import javax.transaction.Transactional;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hieu.businesswebsite.entity.User;
import com.hieu.businesswebsite.entity.UserRole;

@Service
@Transactional
public class UserService {
	
	@Autowired
	SessionFactory sessionFactory;

	public User getUserByUsername(String username) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
		criteria.add(Restrictions.eq("username", username));
		return (User) criteria.uniqueResult();
	}
	
	/*public boolean checkIfLogInParametersCorrect(String username, String password) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
		criteria.add(Restrictions.eq("username", username));
		criteria.add(Restrictions.eq("password", password));
		return criteria.list().size() == 1;
	}*/
	
	public void createUser(String username, String password,
							String email, String firstName, String lastName) {
		User user = new User(username, password, firstName, lastName, email);
		user.getUserRoles().add(new UserRole("USER"));
		sessionFactory.getCurrentSession().persist(user);
	}
	
	public boolean checkIfUsernameIsAvailable(String username) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
		criteria.add(Restrictions.eq("username", username));
		return criteria.uniqueResult() == null;
	}
	
	public boolean checkIfEmailIsAvailable(String email) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
		criteria.add(Restrictions.eq("email", email));
		return criteria.uniqueResult() == null;
	}
}
