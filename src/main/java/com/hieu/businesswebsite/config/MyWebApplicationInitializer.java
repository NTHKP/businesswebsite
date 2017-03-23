package com.hieu.businesswebsite.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class MyWebApplicationInitializer implements WebApplicationInitializer {

	public void onStartup(ServletContext servletContext) throws ServletException {
		AnnotationConfigWebApplicationContext appContext = new AnnotationConfigWebApplicationContext();
		appContext.register(ApplicationContextConfig.class);
		ServletRegistration.Dynamic servlet = servletContext.addServlet("DispatcherServlet", new DispatcherServlet(appContext));
		servlet.setLoadOnStartup(1);
		servlet.addMapping("/");
		
		ContextLoaderListener listener = new ContextLoaderListener(appContext);
		servletContext.addListener(listener);
				
			
		
	}
	
	

}
