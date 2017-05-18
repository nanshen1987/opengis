package com.example;

import java.util.Arrays;
import java.util.Properties;

import com.example.cycle.CustApplicationEnvironmentPreparedEventListener;
import com.example.cycle.CustApplicationPreparedEventListener;
import com.example.cycle.CustApplicationReadyEventListener;
import com.example.cycle.CustApplicationStartingEventListener;
import com.example.message.ActiveMqUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by shennan on 2017/3/27.
 */
@Configuration
@EnableAutoConfiguration
@ComponentScan
@Controller
public class Example {
//    @Autowired
    private ActiveMqUtil activeMqUtil;
    @RequestMapping("/")
    String home() {
        if(true)
        throw new RuntimeException();
        return "Hello World222!";
    }

    @RequestMapping("/index")
    String index() {
        return "index";
    }
    @RequestMapping("/demomap")
    public String mapMain()
    {
        return "demomap";
    }




    @RequestMapping("/activemq")
    String activemq() {
        return "activemq";
    }
    public static void main(String[] args) {
        SpringApplication springApplication = new SpringApplication(Example.class);
        springApplication.setBannerMode(Banner.Mode.OFF);
//        springApplication.addListeners(new CustApplicationEnvironmentPreparedEventListener(),
//                new CustApplicationPreparedEventListener(), new CustApplicationStartingEventListener(),
//                new CustApplicationReadyEventListener());
        springApplication.run(args);

    }


}
