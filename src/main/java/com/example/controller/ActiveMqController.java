package com.example.controller;

import com.example.message.ActiveMqUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by sn on 2017-4-16.
 */
@RestController
@RequestMapping(value="/activemq")
public class ActiveMqController {
//    @Autowired
//    private ActiveMqUtil activeMqUtil;
//
//    @RequestMapping(value="/sendqueue", method= RequestMethod.GET)
//    public Map<String,String> c()
//    {
//        Map<String,String> result=new HashMap<String, String>();
//        result.put("success","1");
//        activeMqUtil.sendMsgQueue();
//        return result;
//    }
//    @RequestMapping(value="/sendtopics", method= RequestMethod.GET)
//    public Map<String,String> sendMsgTopic()
//    {
//        Map<String,String> result=new HashMap<String, String>();
//        result.put("success","1");
//        activeMqUtil.sendMsgTopic();
//        return result;
//    }
}
