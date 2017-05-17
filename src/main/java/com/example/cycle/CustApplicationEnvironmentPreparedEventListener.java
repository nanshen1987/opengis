package com.example.cycle;

import org.springframework.boot.context.event.ApplicationEnvironmentPreparedEvent;
import org.springframework.context.ApplicationListener;

/**
 * Created by shennan on 2017/3/28.
 */
public class CustApplicationEnvironmentPreparedEventListener implements
        ApplicationListener< ApplicationEnvironmentPreparedEvent> {
    @Override public void onApplicationEvent(ApplicationEnvironmentPreparedEvent applicationEnvironmentPreparedEvent) {
        System.out.println("ApplicationEnvironmentPreparedEvent.....................");
    }
}
