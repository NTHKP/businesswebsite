package com.hieu.businesswebsite.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hieu.businesswebsite.entity.User;
import com.hieu.businesswebsite.service.UserService;
import com.hieu.businesswebsite.service.WeatherService;

@Controller
public class UserServiceController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	WeatherService weatherService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@RequestMapping(value={"/", "/home"}, method=RequestMethod.GET)
	public String showHomePage(HttpServletRequest request) {
		UserDetails currentUser = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal instanceof UserDetails) {
			currentUser = (UserDetails) principal;
			User user = userService.getUserByUsername(currentUser.getUsername());
			request.getSession().setAttribute("user", user);
		}
		
		return "home";
	}
	
	@RequestMapping(value={"/", "/home"}, method=RequestMethod.POST)
	public String showWeather(@RequestParam String cityName, HttpServletRequest request) {
		JSONObject jsonObject = new JSONObject(weatherService.getJson(cityName));
		String outCityName = jsonObject.get("name").toString();
		String outWind = jsonObject.getJSONObject("wind").get("speed").toString();
		String outTemp = jsonObject.getJSONObject("main").get("temp").toString();
		
		String outWeather = null;		
		JSONArray weatherArray = jsonObject.getJSONArray("weather");
		for (int i = 0; i < weatherArray.length(); i++) {
			outWeather = weatherArray.getJSONObject(i).get("main").toString();
		}
			
		request.getSession().setAttribute("outCityName", outCityName);
		request.getSession().setAttribute("outWeather", outWeather);
		request.getSession().setAttribute("outWind", outWind);
		request.getSession().setAttribute("outTemp", outTemp);
		
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
	
	@RequestMapping(value="/account", method=RequestMethod.GET)
	public String showAccountPage(@RequestParam(required=false) String editSuccessful, HttpServletRequest request) {
		if(editSuccessful != null && editSuccessful.equals("true")) {
			request.setAttribute("editSuccessful", "You have edited your account information successfully.");
		}
		return "account";
	}
	
	@RequestMapping(value="/account", method=RequestMethod.POST)
	public String editAccount(@RequestParam String username,
								@RequestParam String firstName,
								@RequestParam String lastName,
								@RequestParam String email,
								@RequestParam(required=false) String oldPassword,
								@RequestParam(required=false) String password,
								@RequestParam(required=false) String confirmPassword,
								HttpServletRequest request) {
		
		User user = userService.getUserByUsername(username);
		
		if(!email.equals(user.getEmail()) && !userService.checkIfEmailIsAvailable(email)) {
			request.setAttribute("emailExists", "Email already exists, please choose another one.");
			return "account";
		}
		
		if(oldPassword != null && !oldPassword.trim().equals("")
				&& password != null && !password.trim().equals("")
				&& confirmPassword != null && !confirmPassword.trim().equals("")) {
			
			if(passwordEncoder.matches(oldPassword, user.getPassword())) {
				user = userService.updateUser(username, firstName, lastName, email, passwordEncoder.encode(password));
				request.getSession().setAttribute("user", user);
			} else {
				request.setAttribute("wrongPassword", "Incorrect old password.");
				return "account";
			}
			
			
		} else {
			user = userService.updateUser(username, firstName, lastName, email);
			request.getSession().setAttribute("user", user);
		}
		return "redirect:account?editSuccessful=true";
	}
	
	@RequestMapping(value="/403", method=RequestMethod.GET)
	public String show403Page() {
		return "403";
	}
}
