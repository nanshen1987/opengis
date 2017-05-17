package com.example.cycle;

import org.springframework.boot.context.event.ApplicationPreparedEvent;
import org.springframework.context.ApplicationListener;

/**
 * Created by shennan on 2017/3/28.
 */
public class CustApplicationPreparedEventListener  implements ApplicationListener<  ApplicationPreparedEvent > {

    @Override public void onApplicationEvent(ApplicationPreparedEvent applicationPreparedEvent) {
        System.out.println("ApplicationPreparedEvent..................");
    }
}
