package com.example.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.stereotype.Component;

/**
 * Created by shennan on 2017/3/29.
 */
@Component
public class CustServletContextInitializer implements ServletContextInitializer {
    @Override public void onStartup(ServletContext servletContext) throws ServletException {
        System.out.println("CustServletContextInitializer................");
    }
}
