package com.hieu.businesswebsite.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hieu.businesswebsite.service.UserService;

@Controller
public class UserServiceController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@RequestMapping(value={"/", "/home"}, method=RequestMethod.GET)
	public String showHomePage(HttpServletRequest request) {
		UserDetails user = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal instanceof UserDetails) {
			user = (UserDetails) principal;
		}
		request.getSession().setAttribute("user", user);
		return "home";
	}

	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String showLogInPage(@RequestParam(required=false) String signUpSuccessful,
								@RequestParam(required=false) String error,
								@RequestParam(required=false) String logout, HttpServletRequest request) {
		if(signUpSuccessful != null && signUpSuccessful.equals("true")) {
			request.setAttribute("signUpSuccessful", "Sign up successful! Please log in to continue.");
		}
		if(error != null && error.equals("true")) {
			request.setAttribute("invalidCredentials", "Invalid credentials");
		}
		if(logout != null && logout.equals("true")) {
			request.setAttribute("logOutSuccessful", "You have been logged out successfully.");
		}
		return "login";
	}
	
	/*@RequestMapping(value="/login", method=RequestMethod.POST)
	public String authenticateLogIn(@RequestParam String username, @RequestParam String password,
									HttpServletRequest request) {
		if(!userService.checkIfLogInParametersCorrect(username, passwordEncoder.encode(password))) {
			request.setAttribute("invalidCredentials", "Invalid credentials");
			return "/login";
		}
		User user = userService.getUserByUsername(username);
		request.getSession().setAttribute("user", user);
		return "redirect:home";
	}*/
	
	@RequestMapping(value="/signup", method=RequestMethod.GET)
	public String showSignUpPage() {
		return "signup";
	}
	
	@RequestMapping(value="/signup", method=RequestMethod.POST)
	public String authenticateSignUp(@RequestParam String username, @RequestParam String password,
			@RequestParam String email, @RequestParam String firstName, @RequestParam String lastName,
			HttpServletRequest request) {
		
		if (!userService.checkIfUsernameIsAvailable(username)) {
			request.setAttribute("usernameExists", "Username already exists, please choose another one.");
			return "/signup";
		}
		
		if (!userService.checkIfEmailIsAvailable(email)) {
			request.setAttribute("emailExists", "Email already exists, please choose another one.");
			return "/signup";
		}
		
		userService.createUser(username, passwordEncoder.encode(password), email, firstName, lastName);
		return "redirect:login?signUpSuccessful=true";
	}
	
	@RequestMapping(value="/about", method=RequestMethod.GET)
	public String showAboutPage() {
		return "about";
	}
}
