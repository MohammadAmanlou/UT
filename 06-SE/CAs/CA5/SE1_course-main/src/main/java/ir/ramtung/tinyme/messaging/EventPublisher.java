package ir.ramtung.tinyme.messaging;

import ir.ramtung.tinyme.messaging.event.Event;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Component;

import java.util.logging.Logger;

@Component
public class EventPublisher {
    private final Logger log = Logger.getLogger(this.getClass().getName());
    private final JmsTemplate jmsTemplate;
    @Value("${responseQueue}")
    private String responseQueue;

    public EventPublisher(JmsTemplate jmsTemplate) {
        this.jmsTemplate = jmsTemplate;
    }

    public void publish(Event event) {
        log.info("Published : " + event);
        jmsTemplate.convertAndSend(responseQueue, event);
    }
}
