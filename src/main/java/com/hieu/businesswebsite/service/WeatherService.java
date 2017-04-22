package com.hieu.businesswebsite.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

@Service
public class WeatherService {
	
	@Autowired
	private Environment environment;
	
	public String getJson(String cityName) {
		
			String apiKey = environment.getProperty("apiKey");
			
			Client client = Client.create();

			WebResource webResource = client
			   .resource("http://api.openweathermap.org/data/2.5/weather?q="
		        		+ cityName + "&APPID=" + apiKey);

			ClientResponse response = webResource.accept("application/json")
	                   .get(ClientResponse.class);

			if (response.getStatus() != 200) {
			   throw new RuntimeException("Failed : HTTP error code : "
				+ response.getStatus());
			}

			String output = response.getEntity(String.class);
		
		return output;
	}
}
