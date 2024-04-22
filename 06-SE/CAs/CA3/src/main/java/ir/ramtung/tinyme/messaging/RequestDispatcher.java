package ir.ramtung.tinyme.messaging;

import ir.ramtung.tinyme.messaging.request.DeleteOrderRq;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.domain.service.OrderHandler;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import java.util.logging.Logger;

@Component
public class RequestDispatcher {
    private final Logger log = Logger.getLogger(this.getClass().getName());
    private final OrderHandler orderHandler;

    public RequestDispatcher(OrderHandler orderHandler) {
        this.orderHandler = orderHandler;
    }

    @JmsListener(destination = "${requestQueue}", selector = "_type='ir.ramtung.tinyme.messaging.request.EnterOrderRq'")
    public void receiveEnterOrderRq(EnterOrderRq enterOrderRq) {
        log.info("Received message: " + enterOrderRq);
        orderHandler.handleEnterOrder(enterOrderRq);
    }

    @JmsListener(destination = "${requestQueue}", selector = "_type='ir.ramtung.tinyme.messaging.request.DeleteOrderRq'")
    public void receiveDeleteOrderRq(DeleteOrderRq deleteOrderRq) {
        log.info("Received message: " + deleteOrderRq);
        orderHandler.handleDeleteOrder(deleteOrderRq);
    }
}
