package com.example.bean;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 * Created by shennan on 2017/3/28.
 */
@Component
public class ArgsClRunner implements CommandLineRunner {
    @Override public void run(String... strings) throws Exception {
        System.out.println(strings);
    }
}
