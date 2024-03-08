package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;

@Service
public class Sender {
    @Autowired
    JmsTemplate jms_template;
    @Value("OUTQ")
    String jms_queue;
    public void send_message(String message) {
        jms_template.convertAndSend(jms_queue, message);
    }
}
