package ir.ramtung.tinyme.messaging;

import ir.ramtung.tinyme.domain.entity.Side;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.domain.service.OrderHandler;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.jms.annotation.EnableJms;
import org.springframework.jms.core.JmsTemplate;

import java.time.LocalDateTime;

import static org.mockito.Mockito.timeout;
import static org.mockito.Mockito.verify;

//@Disabled
@SpringBootTest
@EnableJms
public class RequestDispatcherTest {
    @Autowired
    private JmsTemplate jmsTemplate;
    @MockBean
    private OrderHandler mockOrderHandler;
    @Value("${requestQueue}")
    private String requestQueue;

    @BeforeEach
    void emptyRequestQueue() {
        long receiveTimeout = jmsTemplate.getReceiveTimeout();
        jmsTemplate.setReceiveTimeout(1000);
        //noinspection StatementWithEmptyBody
        while (jmsTemplate.receive(requestQueue) != null) ;
        jmsTemplate.setReceiveTimeout(receiveTimeout);
    }

    @Test
    void request_channel_integration_works() {
        EnterOrderRq rq = EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), Side.SELL, 300, 15450, 0, 0, 0);
        jmsTemplate.convertAndSend(requestQueue, rq);
        verify(mockOrderHandler, timeout(1000)).handleEnterOrder(rq);
    }
}
