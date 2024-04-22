package ir.ramtung.tinyme.domain;

import ir.ramtung.tinyme.config.MockedJMSTestConfig;
import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.domain.service.OrderHandler;
import ir.ramtung.tinyme.messaging.EventPublisher;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.TradeDTO;
import ir.ramtung.tinyme.messaging.event.*;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.repository.BrokerRepository;
import ir.ramtung.tinyme.repository.SecurityRepository;
import ir.ramtung.tinyme.repository.ShareholderRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.annotation.DirtiesContext;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@SpringBootTest
@Import(MockedJMSTestConfig.class)
@DirtiesContext
public class StopLimitOrderTest {
    @Autowired
    OrderHandler orderHandler;
    @Autowired
    EventPublisher eventPublisher;
    @Autowired
    SecurityRepository securityRepository;
    @Autowired
    BrokerRepository brokerRepository;
    @Autowired
    ShareholderRepository shareholderRepository;
    private Security security;
    private Shareholder shareholder;
    private Broker broker1;
    private Broker broker2;
    private Broker broker3;

    @BeforeEach
    void setup() {
        securityRepository.clear();
        brokerRepository.clear();
        shareholderRepository.clear();

        security = Security.builder().isin("ABC").build();
        securityRepository.addSecurity(security);

        shareholder = Shareholder.builder().build();
        shareholder.incPosition(security, 100_000);
        shareholderRepository.addShareholder(shareholder);

        broker1 = Broker.builder().brokerId(1).credit(0).build();
        broker2 = Broker.builder().brokerId(2).credit(0).build();
        broker3 = Broker.builder().brokerId(3).credit(0).build();
        brokerRepository.addBroker(broker1);
        brokerRepository.addBroker(broker2);
        brokerRepository.addBroker(broker3);
    }

    @Test
    void updating_stop_price_for_nonStopLimit_order() {
        Broker broker1 = Broker.builder().brokerId(1).credit(100_000).build();
        brokerRepository.addBroker(broker1);
        Order order = new Order(100, security, Side.BUY, 30, 500, broker1, shareholder,0 );
        security.getOrderBook().enqueue(order);

        orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 100, LocalDateTime.now(), Side.BUY, 30, 550,
         broker1.getBrokerId(), shareholder.getShareholderId(), 0, 0 , 10));

        assertThat(broker1.getCredit()).isEqualTo(100_000);
        verify(eventPublisher).publish(new OrderRejectedEvent(1, 100, List.of(Message.UPDATING_REJECTED_BECAUSE_IT_IS_NOT_STOP_LIMIT_ORDER)));
    }

    @Test
    void updating_peakSize_for_StopLimit_order() {
        Broker broker1 = Broker.builder().brokerId(1).credit(100_000).build();
        brokerRepository.addBroker(broker1);
        Order order = new StopLimitOrder(100, security, Side.BUY, 30, 500, broker1, shareholder,
         10 , 0 );
        security.getOrderBook().enqueue(order);

        orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 100, LocalDateTime.now(), Side.BUY, 30, 550,
         broker1.getBrokerId(), shareholder.getShareholderId(), 10, 0 , 10));

        assertThat(broker1.getCredit()).isEqualTo(100_000);
        verify(eventPublisher).publish(new OrderRejectedEvent(1, 100, List.of(Message.STOP_LIMIT_ORDER_CANT_ICEBERG)));
    }

    @Test
    void updating_MEQ_for_StopLimit_order() {
        Broker broker1 = Broker.builder().brokerId(1).credit(100_000).build();
        brokerRepository.addBroker(broker1);
        Order order = new StopLimitOrder(100, security, Side.BUY, 30, 500, broker1, shareholder,
         10 , 0 );
        security.getOrderBook().enqueue(order);

        orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 100, LocalDateTime.now(), Side.BUY, 30, 550,
         broker1.getBrokerId(), shareholder.getShareholderId(), 0, 10 , 10));

        assertThat(broker1.getCredit()).isEqualTo(100_000);
        verify(eventPublisher).publish(new OrderRejectedEvent(1, 100, List.of(Message.STOP_LIMIT_ORDER_CANT_MEQ)));
    }

    @Test
    void MEQ_for_StopLimit_order() {
        Broker broker1 = Broker.builder().brokerId(1).credit(100_000).build();
        brokerRepository.addBroker(broker1);
        Order order = new StopLimitOrder(100, security, Side.BUY, 30, 500, broker1, shareholder,
         10 , 10);
        security.getOrderBook().enqueue(order);

        orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 100, LocalDateTime.now(), Side.BUY, 30, 550,
        broker1.getBrokerId(), shareholder.getShareholderId(), 0, 10 , 10));

        assertThat(broker1.getCredit()).isEqualTo(100_000);
        verify(eventPublisher).publish(new OrderRejectedEvent(1, 100, List.of(Message.STOP_LIMIT_ORDER_CANT_MEQ)));
    }

    @Test
    void new_stopLimit_not_matching() { //new_order_from_buyer_with_enough_credit_based_on_trades
        Broker broker1 = Broker.builder().brokerId(10).credit(100_000).build();
        Broker broker2 = Broker.builder().brokerId(20).credit(100_000).build();
        Broker broker3 = Broker.builder().brokerId(30).credit(520_500).build();
        List.of(broker1, broker2, broker3).forEach(b -> brokerRepository.addBroker(b));
        Order matchingSellOrder1 = new Order(100, security, Side.SELL, 30, 500, broker1, shareholder,0);
        Order matchingSellOrder2 = new Order(110, security, Side.SELL, 20, 400, broker1, shareholder,0);
        security.getOrderBook().enqueue(matchingSellOrder1);
        security.getOrderBook().enqueue(matchingSellOrder2);
     
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), 
        Side.BUY, 10, 700, broker2.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 600));



        assertThat(broker1.getCredit()).isEqualTo(100_000 );
        assertThat(broker2.getCredit()).isEqualTo(93000 );
        assertThat(broker3.getCredit()).isEqualTo(520_500);

        verify(eventPublisher).publish(new OrderAcceptedEvent(1, 200));
    }

    @Test
    void prev_SLO_matched_completely_with_one_trade() {
        Order matchingBuyOrder = new StopLimitOrder(100, security, Side.BUY, 1000, 15500, broker1, shareholder,   10 , 0);
        Order incomingSellOrder = new StopLimitOrder(200, security, Side.SELL, 300, 15450, broker2, shareholder,   10 , 0);
        security.getOrderBook().enqueue(matchingBuyOrder);
        

        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), Side.SELL, 
        300, 15450, broker2.getBrokerId(), shareholder.getShareholderId(), 0, 100));
        Trade trade = new Trade(security, matchingBuyOrder.getPrice(), incomingSellOrder.getQuantity(),
        matchingBuyOrder, incomingSellOrder);
        
        assertThat(broker1.getCredit()).isEqualTo(0 );
        assertThat(broker2.getCredit()).isEqualTo(4650000 );
        verify(eventPublisher).publish((new OrderAcceptedEvent(1, 200)));
        verify(eventPublisher).publish(new OrderExecutedEvent(1, 200, List.of(new TradeDTO(trade))));
    }


    @Test
    void prev_SLO_from_buyer_matching_partly() { 
        Broker broker1 = Broker.builder().brokerId(10).credit(100_000).build();
        Broker broker2 = Broker.builder().brokerId(20).credit(100_000).build();
        Broker broker3 = Broker.builder().brokerId(30).credit(520_500).build();
        List.of(broker1, broker2, broker3).forEach(b -> brokerRepository.addBroker(b));
        Order order1 = new StopLimitOrder(100, security, Side.SELL, 30, 500, broker1, shareholder,   10 , 0);
        Order order2 = new StopLimitOrder(110, security, Side.SELL, 20, 400, broker2, shareholder,   10 , 0);
        security.getOrderBook().enqueue(order1);
        security.getOrderBook().enqueue(order2);
     
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), 
        Side.BUY, 200, 950, broker3.getBrokerId(), shareholder.getShareholderId(), 0,100));

        assertThat(broker1.getCredit()).isEqualTo(100_000 );
        assertThat(broker2.getCredit()).isEqualTo(100_000 );
        assertThat(broker3.getCredit()).isEqualTo(520_500);

        verify(eventPublisher).publish(new OrderAcceptedEvent(1, 200));

    }

    @Test
    void prev_SLO_from_buyer_matching_all_new_MEQ_order() { //new_order_from_buyer_with_enough_credit_based_on_trades
        Broker broker1 = Broker.builder().brokerId(10).credit(100_000).build();
        Broker broker2 = Broker.builder().brokerId(20).credit(100_000).build();
        Broker broker3 = Broker.builder().brokerId(30).credit(520_500).build();
        List.of(broker1, broker2, broker3).forEach(b -> brokerRepository.addBroker(b));

        Order order1 = new StopLimitOrder(100, security, Side.SELL, 30, 500, broker1, shareholder,   10 , 0);
        Order order2 = new StopLimitOrder(110, security, Side.SELL, 20, 400, broker2, shareholder,   10 , 0);

        security.getOrderBook().enqueue(order1);
        security.getOrderBook().enqueue(order2);
     
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), 
        Side.BUY, 100, 950, broker3.getBrokerId(), shareholder.getShareholderId(), 0,10));

        assertThat(broker1.getCredit()).isEqualTo(115000 );
        assertThat(broker2.getCredit()).isEqualTo(108_000 );
        assertThat(broker3.getCredit()).isEqualTo(450000);

        verify(eventPublisher).publish(new OrderAcceptedEvent(1, 200));
    }

    @Test
    void prev_SLO_matched_with_one_trade() {
        Broker broker1 = Broker.builder().brokerId(1).credit(100_000).build();
        brokerRepository.addBroker(broker1);
        Order order = new StopLimitOrder(100, security, Side.BUY, 30, 500, broker1, shareholder,   10 , 0);
        security.getOrderBook().enqueue(order);

        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(),    Side.BUY,
         50, 550, broker1.getBrokerId(), shareholder.getShareholderId(), 0,1));

        assertThat(broker1.getCredit()).isEqualTo(100_000 );
        assertThat(broker2.getCredit()).isEqualTo(0 );
        verify(eventPublisher).publish(new OrderAcceptedEvent(1, 100));
    }

    @Test
    void new_stopLimit_Matching_changing_lastTradePrice() { //new_order_from_buyer_with_enough_credit_based_on_trades
        Broker broker1 = Broker.builder().brokerId(10).credit(100_000).build();
        Broker broker2 = Broker.builder().brokerId(20).credit(100_000).build();
        Broker broker3 = Broker.builder().brokerId(30).credit(520_500).build();
        List.of(broker1, broker2, broker3).forEach(b -> brokerRepository.addBroker(b));
        Order matchingSellOrder1 = new Order(100, security, Side.SELL, 30, 500, broker1, shareholder,0);
        Order matchingSellOrder2 = new Order(110, security, Side.SELL, 20, 400, broker1, shareholder,0);
        security.getOrderBook().enqueue(matchingSellOrder1);
        security.getOrderBook().enqueue(matchingSellOrder2);

        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 400, LocalDateTime.now(), 
        Side.BUY, 10, 700, broker3.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 ));
     
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), 
        Side.BUY, 10, 900, broker2.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 800));



        assertThat(broker1.getCredit()).isEqualTo(108000 );
        assertThat(broker2.getCredit()).isEqualTo(87000 );
        assertThat(broker3.getCredit()).isEqualTo(516500);
    }



    @Test
    void new_stopLimit_notMatching_changing_lastTradePrice() { 
        Broker broker1 = Broker.builder().brokerId(10).credit(100_000).build();
        Broker broker2 = Broker.builder().brokerId(20).credit(100_000).build();
        Broker broker3 = Broker.builder().brokerId(30).credit(520_500).build();
        List.of(broker1, broker2, broker3).forEach(b -> brokerRepository.addBroker(b));
        Order matchingSellOrder1 = new Order(100, security, Side.SELL, 30, 500, broker1, shareholder,0);
        Order matchingSellOrder2 = new Order(110, security, Side.SELL, 20, 400, broker1, shareholder,0);
        security.getOrderBook().enqueue(matchingSellOrder1);
        security.getOrderBook().enqueue(matchingSellOrder2);

        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 400, LocalDateTime.now(), 
        Side.BUY, 10, 700, broker3.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 ));
     
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), 
        Side.BUY, 10, 700, broker2.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 200));


        assertThat(broker1.getCredit()).isEqualTo(104000 );
        assertThat(broker2.getCredit()).isEqualTo(93000 );
        assertThat(broker3.getCredit()).isEqualTo(516500);

    }




}
