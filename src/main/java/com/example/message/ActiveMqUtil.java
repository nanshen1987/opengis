package com.example.message;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Random;
import java.util.UUID;

/**
 * Created by sn on 2017-4-16.
 */
public class ActiveMqUtil {
//    private final JmsTemplate jmsTemplate;
//
//    @Autowired
//    public ActiveMqUtil(JmsTemplate jmsTemplate)
//    {
//        this.jmsTemplate=jmsTemplate;
//    }

//    public void sendMsgQueue()
//    {
//            jmsTemplate.send("testAmq",new MessageCreator() {
//                @Override
//                public Message createMessage(Session session) throws JMSException {
//                    return session.createTextMessage("send:"+ UUID.randomUUID());
//                }
//            });
//    }
//
//    public void sendMsgTopic()
//    {
//        jmsTemplate.send("testAmqTopic",new MessageCreator() {
//            @Override
//            public Message createMessage(Session session) throws JMSException {
//                return session.createTextMessage("send:"+ UUID.randomUUID());
//            }
//        });
//    }
}
