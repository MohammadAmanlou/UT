package ir.ramtung.tinyme.messaging;

import ir.ramtung.tinyme.messaging.event.OrderExecutedEvent;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jms.annotation.EnableJms;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.test.annotation.DirtiesContext;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

//@Disabled
@SpringBootTest
@EnableJms
@DirtiesContext
public class EventPublisherTest {
    @Autowired
    JmsTemplate jmsTemplate;
    @Autowired
    EventPublisher eventPublisher;
    @Value("${responseQueue}")
    private String responseQueue;

    @BeforeEach
    void emptyResponseQueue() {
        long receiveTimeout = jmsTemplate.getReceiveTimeout();
        jmsTemplate.setReceiveTimeout(1000);
        //noinspection StatementWithEmptyBody
        while (jmsTemplate.receive(responseQueue) != null) ;
        jmsTemplate.setReceiveTimeout(receiveTimeout);
    }
    @Test
    void response_channel_integration_works() {
        OrderExecutedEvent orderExecutedEvent = new OrderExecutedEvent(1, 0, List.of());
        eventPublisher.publish(orderExecutedEvent);

        long receiveTimeout = jmsTemplate.getReceiveTimeout();
        jmsTemplate.setReceiveTimeout(1000);
        OrderExecutedEvent responseReceived = (OrderExecutedEvent) jmsTemplate.receiveAndConvert(responseQueue);
        assertEquals(orderExecutedEvent, responseReceived);

        jmsTemplate.setReceiveTimeout(receiveTimeout);
    }
}
