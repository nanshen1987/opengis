package com.example.cycle;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;

/**
 * Created by shennan on 2017/3/28.
 */
public class CustApplicationReadyEventListener  implements ApplicationListener< ApplicationReadyEvent> {

    @Override public void onApplicationEvent(ApplicationReadyEvent applicationReadyEvent) {
        SpringApplication app=applicationReadyEvent.getSpringApplication();
         applicationReadyEvent.getApplicationContext().getEnvironment();
        System.out.println("ApplicationReadyEvent................");
    }
}
