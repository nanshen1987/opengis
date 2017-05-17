package com.example.bean;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

/**
 * Created by shennan on 2017/3/28.
 */
@Component
public class ArgApplicationRunner implements ApplicationRunner {
    @Override public void run(ApplicationArguments applicationArguments) throws Exception {
        System.out.println("test here");
    }
}
