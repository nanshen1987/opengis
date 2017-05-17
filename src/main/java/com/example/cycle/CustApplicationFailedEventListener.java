package com.example.cycle;

import org.springframework.boot.context.event.ApplicationFailedEvent;
import org.springframework.context.ApplicationListener;

/**
 * Created by shennan on 2017/3/28.
 */
public class CustApplicationFailedEventListener  implements ApplicationListener< ApplicationFailedEvent> {

    @Override public void onApplicationEvent(ApplicationFailedEvent applicationFailedEvent) {
        System.out.println("ApplicationFailedEvent......................");
    }
}
