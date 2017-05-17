package com.example.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.entity.Customer;
import com.example.entity.User;

/**
 * Created by shennan on 2017/3/29.
 */
@RestController
@RequestMapping(value="/users")
public class MyRestController {
    @RequestMapping(value="/{user}", method= RequestMethod.GET)
    public User getUser(@PathVariable Long user) {
        User userVo=new User();
        userVo.setAddress("Pukou");
        userVo.setAge(10);
        userVo.setName("shennan");
        return userVo;
    }
    @RequestMapping(value="/{user}/customers", method=RequestMethod.GET) List<Customer> getUserCustomers(@PathVariable Long user) {
        List<Customer> customers=new ArrayList<Customer>();
        Customer customer1=new Customer();
        customer1.setLevel(0);
        customer1.setOldFlag("0");
        customer1.setName("shennan");
        Customer customer2=new Customer();
        customer2.setLevel(2);
        customer2.setOldFlag("2");
        customer2.setName("shendan");
        customers.add(customer1);
        customers.add(customer2);
        return customers;
    }
    @RequestMapping(value="/{user}", method=RequestMethod.DELETE)
    public User deleteUser(@PathVariable Long user) {
        User userVo=new User();
        userVo.setAddress("Pukou");
        userVo.setAge(10);
        userVo.setName("shennan");
        return userVo;
    }


}
