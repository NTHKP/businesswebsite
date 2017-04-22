package com.hieu.businesswebsite.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.hieu.businesswebsite.service.SpringSecurityUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private SpringSecurityUserDetailsService userDetailsService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
	}
	
	@Override
	public void configure(HttpSecurity http) throws Exception {
		http
			.authorizeRequests()
				.antMatchers("/add-products", "/edit-product", "/orders-management", "/update-order-status").hasAnyRole("ADMIN")
				.antMatchers("/orders", "/shopping-cart", "/account", "/remove-from-cart", "/update-cart").hasAnyRole("ADMIN", "USER")
				.anyRequest().permitAll()
			.and().formLogin()
				.loginPage("/login")
				.defaultSuccessUrl("/home", true)
				.failureUrl("/login?error=true")
				.usernameParameter("username")
				.passwordParameter("password")
			.and().logout()
				.logoutSuccessUrl("/login?logout=true")
			.and().exceptionHandling().accessDeniedPage("/403")
			.and().csrf().disable();
	}
	
}
