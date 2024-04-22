package ir.ramtung.tinyme.domain;

import ir.ramtung.tinyme.config.MockedJMSTestConfig;
import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.domain.service.OrderHandler;
import ir.ramtung.tinyme.messaging.EventPublisher;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.event.OrderRejectedEvent;
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
import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;

@SpringBootTest
@Import(MockedJMSTestConfig.class)
@DirtiesContext
public class OrderHandlerCreditCheckRollbackTest {
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

    @BeforeEach
    void setup() {
        securityRepository.clear();
        shareholderRepository.clear();
        brokerRepository.clear();

        security = Security.builder().build();
        securityRepository.addSecurity(security);

        shareholder = Shareholder.builder().build();
        shareholderRepository.addShareholder(shareholder);
        shareholder.incPosition(security, 100_000);
    }
    @Test
    void new_order_from_buyer_with_not_enough_credit_based_on_trades() {
        Broker broker1 = Broker.builder().brokerId(1).credit(100_000).build();
        Broker broker2 = Broker.builder().brokerId(2).credit(100_000).build();
        Broker broker3 = Broker.builder().brokerId(3).credit(50_000).build();
        brokerRepository.addBroker(broker1);
        brokerRepository.addBroker(broker2);
        brokerRepository.addBroker(broker3);
        OrderBook orderBook = security.getOrderBook();
        List<Order> orders = Arrays.asList(
                new Order(100, security, Side.SELL, 30, 500, broker1, shareholder,0),
                new Order(110, security, Side.SELL, 20, 500, broker2, shareholder,0),
                new Order(120, security, Side.SELL, 20, 600, broker2, shareholder,0)
        );
        orders.forEach(orderBook::enqueue);


        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, security.getIsin(), 200, LocalDateTime.now(), Side.BUY, 100, 550, broker3.getBrokerId(), shareholder.getShareholderId(), 0, 0));

        assertThat(broker1.getCredit()).isEqualTo(100_000);
        assertThat(broker2.getCredit()).isEqualTo(100_000);
        assertThat(broker3.getCredit()).isEqualTo(50_000);

        assertThat(orderBook.getBuyQueue()).isEmpty();
        assertThat(orderBook.getSellQueue()).extracting("orderId")
                .containsExactly(100L, 110L, 120L);
        assertThat(orderBook.getSellQueue()).extracting("quantity")
                .containsExactly(30, 20, 20);
        assertThat(orderBook.getSellQueue()).extracting("price")
                .containsExactly(500, 500, 600);

        verify(eventPublisher).publish(new OrderRejectedEvent(1, 200, List.of(Message.BUYER_HAS_NOT_ENOUGH_CREDIT)));
    }

    @Test
    void new_order_from_buyer_with_not_enough_credit_based_on_trades_with_iceberg_orders() {
        Broker broker1 = Broker.builder().brokerId(1).credit(100_000).build();
        Broker broker2 = Broker.builder().brokerId(2).credit(100_000).build();
        Broker broker3 = Broker.builder().brokerId(3).credit(92_650).build();
        brokerRepository.addBroker(broker1);
        brokerRepository.addBroker(broker2);
        brokerRepository.addBroker(broker3);
        OrderBook orderBook = security.getOrderBook();
        List<Order> orders = Arrays.asList(
                new IcebergOrder(1, security, Side.SELL, 45, 1545, broker1, shareholder, 200,0),
                new Order(2, security, Side.SELL, 7, 1545, broker2, shareholder, 0),
                new Order(3, security, Side.SELL, 10, 1550, broker2, shareholder, 0)
        );
        orders.forEach(orderBook::enqueue);

        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, security.getIsin(), 200, LocalDateTime.now(),
                Side.BUY, 60, 1545, broker3.getBrokerId(), shareholder.getShareholderId(), 0, 0));

        assertThat(broker1.getCredit()).isEqualTo(100_000);
        assertThat(broker2.getCredit()).isEqualTo(100_000);
        assertThat(broker3.getCredit()).isEqualTo(92_650);

        assertThat(orderBook.getBuyQueue()).isEmpty();
        assertThat(orderBook.getSellQueue()).extracting("orderId")
                .containsExactly(1L, 2L, 3L);
        assertThat(orderBook.getSellQueue()).extracting("quantity")
                .containsExactly(45, 7, 10);
        assertThat(orderBook.getSellQueue()).extracting("price")
                .containsExactly(1545, 1545, 1550);

        verify(eventPublisher).publish(new OrderRejectedEvent(1, 200, List.of(Message.BUYER_HAS_NOT_ENOUGH_CREDIT)));
    }

    @Test
    void update_order_from_buyer_with_not_enough_credit_based_on_trades_with_iceberg_orders() {
        Broker broker1 = Broker.builder().brokerId(1).credit(100_000).build();
        Broker broker2 = Broker.builder().brokerId(2).credit(100_000).build();
        Broker broker3 = Broker.builder().brokerId(3).credit(100).build();
        brokerRepository.addBroker(broker1);
        brokerRepository.addBroker(broker2);
        brokerRepository.addBroker(broker3);
        OrderBook orderBook = security.getOrderBook();
        List<Order> orders = Arrays.asList(
                new IcebergOrder(1, security, Side.SELL, 45, 1545, broker1, shareholder, 200,0),
                new Order(2, security, Side.SELL, 7, 1545, broker2, shareholder, 0),
                new Order(3, security, Side.SELL, 10, 1550, broker2, shareholder, 0),
                new Order(4, security, Side.BUY, 60, 1540, broker3, shareholder, 0)
        );
        orders.forEach(orderBook::enqueue);

        orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, security.getIsin(), 4, LocalDateTime.now(),
                Side.BUY, 60, 1545, broker3.getBrokerId(), shareholder.getShareholderId(), 0, 0));

        assertThat(broker1.getCredit()).isEqualTo(100_000);
        assertThat(broker2.getCredit()).isEqualTo(100_000);
        assertThat(broker3.getCredit()).isEqualTo(100);

        assertThat(orderBook.getBuyQueue().size()).isEqualTo(1);
        assertThat(orderBook.getBuyQueue().get(0)).extracting("orderId", "quantity", "price")
                .containsExactly(4L, 60, 1540);
        assertThat(orderBook.getSellQueue()).extracting("orderId")
                .containsExactly(1L, 2L, 3L);
        assertThat(orderBook.getSellQueue()).extracting("quantity")
                .containsExactly(45, 7, 10);
        assertThat(orderBook.getSellQueue()).extracting("price")
                .containsExactly(1545, 1545, 1550);

        verify(eventPublisher).publish(new OrderRejectedEvent(1, 4, List.of(Message.BUYER_HAS_NOT_ENOUGH_CREDIT)));
    }
}
