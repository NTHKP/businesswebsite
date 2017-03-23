package com.hieu.businesswebsite.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hieu.businesswebsite.entity.User;
import com.hieu.businesswebsite.entity.UserRole;

@Service
public class SpringSecurityUserDetailsService implements UserDetailsService {
	
	@Autowired
	UserService userService;
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userService.getUserByUsername(username);
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		for(UserRole userRole : user.getUserRoles()) {
			authorities.add(new SimpleGrantedAuthority("ROLE_" + userRole.getRole()));
		}
		return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), authorities);
	}

}
