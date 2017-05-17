package com.example.cycle;

import org.springframework.boot.context.event.ApplicationStartingEvent;
import org.springframework.context.ApplicationListener;

/**
 * Created by shennan on 2017/3/28.
 */
public class CustApplicationStartingEventListener implements ApplicationListener<ApplicationStartingEvent> {

    @Override public void onApplicationEvent(ApplicationStartingEvent applicationStartingEvent) {
        System.out.println("ApplicationStartingEvent...........");
    }
}
