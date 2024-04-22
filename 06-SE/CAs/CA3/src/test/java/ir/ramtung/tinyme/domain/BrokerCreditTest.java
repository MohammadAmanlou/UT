package ir.ramtung.tinyme.domain;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.annotation.DirtiesContext;
import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.domain.service.Matcher;
import ir.ramtung.tinyme.messaging.exception.InvalidRequestException;
import ir.ramtung.tinyme.messaging.request.DeleteOrderRq;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.config.MockedJMSTestConfig;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.fail;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@SpringBootTest
@Import(MockedJMSTestConfig.class)
@DirtiesContext
public class BrokerCreditTest {
    private Security security;
    private Broker broker1;
    private Broker broker2;
    private Shareholder shareholder;
    private OrderBook orderBook;
    private List<Order> orders;
    @Autowired
    private Matcher matcher;

     @BeforeEach
    void setupOrderBook() {
        security = Security.builder().build();
        broker1 = Broker.builder().brokerId(1).credit(100_000_000L).build();
        broker2 = Broker.builder().brokerId(2).credit(0).build();
        shareholder = Shareholder.builder().shareholderId(1).build();
        shareholder.incPosition(security, 100_000);
        orderBook = security.getOrderBook();
        orders = Arrays.asList(
            new Order(1, security, Side.BUY, 304, 15700, broker1, shareholder),
            new Order(2, security, Side.BUY, 43, 15500, broker1, shareholder),
            new Order(3, security, Side.BUY, 445, 15450, broker1, shareholder),
            new Order(4, security, Side.BUY, 526, 15450, broker1, shareholder),
            new Order(5, security, Side.BUY, 1000, 15400, broker1, shareholder),
            new Order(6, security, Side.SELL, 350, 15800, broker1, shareholder),
            new Order(7, security, Side.SELL, 285, 15810, broker1, shareholder),
            new Order(8, security, Side.SELL, 800, 15810, broker1, shareholder),
            new Order(9, security, Side.SELL, 340, 15820, broker1, shareholder),
            new Order(10, security, Side.SELL, 65, 15820, broker1, shareholder)
        );
        orders.forEach(order -> orderBook.enqueue(order));
    }

    @Test
    void partially_matching_new_sell_order_disparate_brokers_credit(){
        Order newOrder = new Order(11, security, Side.SELL, 1000, 15700, broker2, shareholder);
        MatchResult result = matcher.execute(newOrder);
        assertThat(broker2.getCredit()).isEqualTo(4772800);
    }

    @Test
    void partially_matching_new_buy_order_disparate_brokers_credit(){
        broker2.increaseCreditBy(100_000_000L);
        Order newOrder = new Order(11, security, Side.BUY, 1000, 15800, broker2, shareholder);
        MatchResult result = matcher.execute(newOrder);
        assertThat(broker2.getCredit()).isEqualTo(84200000);
    }

    @Test
    void completely_matching_new_sell_order_disparate_brokers_credit(){
        Order newOrder = new Order(11, security, Side.SELL, 1000, 15500, broker2, shareholder);
        MatchResult result = matcher.execute(newOrder);
        assertThat(broker2.getCredit()).isEqualTo(5439300);
    }

    @Test
    void completely_matching_new_buy_order_disparate_brokers_credit(){
        broker2.increaseCreditBy(100_000_000L);
        Order newOrder = new Order(11, security, Side.BUY, 500, 15900, broker2, shareholder);
        MatchResult result = matcher.execute(newOrder);
        assertThat(broker2.getCredit()).isEqualTo(92098500);
    }

    @Test
    void new_buy_without_enough_credit(){
        broker2.increaseCreditBy(100);
        Order newOrder = new Order(11, security, Side.BUY, 1000, 15500, broker2, shareholder);
        MatchResult result = matcher.execute(newOrder);
        assertThat(broker2.getCredit()).isEqualTo(100);
        assertThat(result.outcome()).isEqualTo(MatchingOutcome.NOT_ENOUGH_CREDIT);
    }

    @Test
    void new_buy_without_partially_enough_credit(){
        broker2.increaseCreditBy(18_000_000L);
        Order newOrder = new Order(11, security, Side.BUY, 1500, 15810, broker2, shareholder);
        MatchResult result = matcher.execute(newOrder);
        assertThat(broker2.getCredit()).isEqualTo(18_000_000L);
        assertThat(result.outcome()).isEqualTo(MatchingOutcome.NOT_ENOUGH_CREDIT);
    }

    @Test
    void new_sell_match_with_previous_iceberg_order(){
        security = Security.builder().build();
        OrderBook orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new IcebergOrder(1, security, Side.BUY, 1000, 2000, broker1, shareholder, 200),
                new Order(2, security, Side.BUY, 100, 1600, broker1, shareholder),
                new Order(3, security, Side.BUY, 10, 3000, broker1, shareholder),
                new Order(4, security, Side.BUY, 100, 1900, broker1, shareholder),
                new IcebergOrder(5, security, Side.BUY, 500, 1000, broker1, shareholder, 10)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        Order order = new Order(6, security, Side.SELL, 800, 1900, broker2, shareholder);
        MatchResult result = matcher.execute(order);
        assertThat(broker2.getCredit()).isEqualTo(1610000);
    }

    @Test
    void cancel_new_sell_order() throws InvalidRequestException{
        security = Security.builder().isin("MMD").build();
        OrderBook orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new Order(2, security, Side.BUY, 100, 1600, broker1, shareholder),
                new Order(3, security, Side.BUY, 10, 3000, broker1, shareholder),
                new Order(4, security, Side.BUY, 100, 1900, broker1, shareholder),
                new IcebergOrder(5, security, Side.BUY, 500, 1000, broker1, shareholder, 10)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        Order order = new Order(6, security, Side.SELL, 800, 1900, broker2, shareholder);
        MatchResult result = matcher.execute(order);
        security.deleteOrder(new DeleteOrderRq(1,"MMD", Side.SELL, 6));
        assertThat(broker2.getCredit()).isEqualTo(220000);
    }

    @Test
    void cancel_previous_sell_order() throws InvalidRequestException{
        security = Security.builder().isin("MMD").build();
        OrderBook orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new Order(1, security, Side.SELL, 100, 1600, broker1, shareholder),
                new Order(2, security, Side.SELL, 10, 3000, broker1, shareholder),
                new Order(3, security, Side.SELL, 100, 1900, broker1, shareholder),
                new IcebergOrder(4, security, Side.SELL, 500, 5000, broker1, shareholder, 10)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        Order order = new Order(6, security, Side.BUY, 800, 4000, broker1, shareholder);
        MatchResult result = matcher.execute(order);
        security.deleteOrder(new DeleteOrderRq(1,"MMD", Side.SELL, 4));
        long broker1_credit1 = broker1.getCredit();
        Order order_new = new Order(7, security, Side.BUY, 800, 5100, broker1, shareholder);
        matcher.execute(order_new);
        assertThat(broker1.getCredit()).isEqualTo(broker1_credit1 - 800 * 5100);
    }

    @Test
    void cancel_previous_buy_order() throws InvalidRequestException{
        security = Security.builder().isin("MMD").build();
        OrderBook orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new Order(2, security, Side.BUY, 100, 1600, broker1, shareholder),
                new Order(3, security, Side.BUY, 10, 3000, broker1, shareholder),
                new Order(4, security, Side.BUY, 100, 1900, broker1, shareholder),
                new IcebergOrder(5, security, Side.BUY, 500, 1000, broker1, shareholder, 10)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        security.deleteOrder(new DeleteOrderRq(1,"MMD", Side.BUY, 2));
        assertThat(broker1.getCredit()).isEqualTo(100160000);
    }

    @Test
    void cancel_new_buy_order() throws InvalidRequestException{
        security = Security.builder().isin("MMD").build();
        broker2.increaseCreditBy(4000000);
        long mmd = broker2.getCredit();
        OrderBook orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new Order(1, security, Side.SELL, 100, 1600, broker1, shareholder),
                new Order(2, security, Side.SELL, 10, 3000, broker1, shareholder),
                new Order(3, security, Side.SELL, 100, 1900, broker1, shareholder),
                new IcebergOrder(4, security, Side.SELL, 500, 5000, broker1, shareholder, 10)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        Order order = new Order(6, security, Side.BUY, 800, 5000, broker2, shareholder);
        MatchResult result = matcher.execute(order);
        security.deleteOrder(new DeleteOrderRq(1,"MMD", Side.BUY, 6));
        assertThat(broker2.getCredit()).isEqualTo(1120000);
    }

    @Test
    void increasing_amend_buy_order_trade_happen() throws InvalidRequestException{
        Order order = orderBook.findByOrderId(Side.BUY , 1);
        EnterOrderRq enterOrderRq = EnterOrderRq.createUpdateOrderRq(
                1,
                order.getSecurity().getIsin(),
                order.getOrderId(),
                LocalDateTime.now(),
                order.getSide(),
                10000,
                1100000000,
                order.getBroker().getBrokerId(),
                order.getShareholder().getShareholderId(),
                0
        );
        MatchResult matchResult = security.updateOrder(enterOrderRq, new Matcher());
        assertThat(broker1.getCredit()).isEqualTo(100000000);
        assertThat(matchResult.outcome()).isEqualTo(MatchingOutcome.NOT_ENOUGH_CREDIT);
        assertThat(matchResult.trades()).isEmpty();
    }

    @Test
    void increasing_amend_buy_order_trade_not_happen() throws InvalidRequestException{
        Order order = orderBook.findByOrderId(Side.BUY , 1);
        EnterOrderRq enterOrderRq = EnterOrderRq.createUpdateOrderRq(
                1,
                order.getSecurity().getIsin(),
                order.getOrderId(),
                LocalDateTime.now(),
                order.getSide(),
                400,
                15750,
                order.getBroker().getBrokerId(),
                order.getShareholder().getShareholderId(),
                0
        );
        MatchResult matchResult = security.updateOrder(enterOrderRq, new Matcher());
        assertThat(broker1.getCredit()).isEqualTo(98472800);
        assertThat(matchResult.outcome()).isEqualTo(MatchingOutcome.EXECUTED);
        assertThat(matchResult.trades()).isEmpty();
    }

    @Test
    void decreasing_amend_buy_order_trade_happen() {
        Order order = new Order(11, security, Side.SELL, 100, 50000, broker2, shareholder);
        MatchResult result = matcher.execute(order);
        broker1.increaseCreditBy(1000000000);
        EnterOrderRq enterOrderRq = EnterOrderRq.createUpdateOrderRq(
                11,
                security.getIsin(),
                1,
                LocalDateTime.now(),
                Side.BUY,
                5000,
                60000,
                broker1.getBrokerId(),
                shareholder.getShareholderId(),
                0
        );
        MatchResult matchResult = security.newOrder(enterOrderRq, broker1, shareholder, new Matcher());
        assertThat(matchResult.outcome()).isEqualTo(MatchingOutcome.EXECUTED);
        assertThat(matchResult.remainder().getValue()).isEqualTo(183600000);
        assertThat(matchResult.trades()).isNotEmpty();
        assertThat(broker2.getCredit()).isEqualTo(5000000);

    }

    @Test
    void amend_sell_order_not_changing_credit(){
        EnterOrderRq enterOrderRq = EnterOrderRq.createUpdateOrderRq(
                11,
                security.getIsin(),
                6,
                LocalDateTime.now(),
                Side.SELL,
                400,
                16000,
                broker1.getBrokerId(),
                shareholder.getShareholderId(),
                0
        );
        MatchResult matchResult = security.newOrder(enterOrderRq, broker1, shareholder, new Matcher());
        assertThat(matchResult.outcome()).isEqualTo(MatchingOutcome.EXECUTED);
        assertThat(matchResult.remainder().getValue()).isEqualTo(6400000);
        assertThat(matchResult.trades()).isEmpty();
        assertThat(broker1.getCredit()).isEqualTo(100000000);
    }

    @Test
    void amend_sell_order_changing_credit(){
        EnterOrderRq enterOrderRq = EnterOrderRq.createUpdateOrderRq(
                11,
                security.getIsin(),
                6,
                LocalDateTime.now(),
                Side.SELL,
                300,
                15700,
                broker1.getBrokerId(),
                shareholder.getShareholderId(),
                0
        );
        MatchResult matchResult = security.newOrder(enterOrderRq, broker1, shareholder, new Matcher());
        assertThat(matchResult.outcome()).isEqualTo(MatchingOutcome.EXECUTED);
        assertThat(matchResult.remainder().getValue()).isEqualTo(0);
        assertThat(matchResult.trades()).isNotEmpty();
        assertThat(broker1.getCredit()).isEqualTo(104710000);

    }

    @Test
    void amend_buy_iceberg_order_increase_everyThing() throws InvalidRequestException{
        security = Security.builder().isin("MMD").build();
        broker2.increaseCreditBy(4000000);
        OrderBook orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new IcebergOrder(1, security, Side.BUY, 45, 1550, broker1, shareholder , 15),
                new Order(2, security, Side.BUY, 7, 1550, broker1, shareholder),
                new Order(3, security, Side.BUY, 100, 1530, broker1, shareholder),
                new Order(4, security, Side.SELL, 45, 1560, broker2, shareholder)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        security.updateOrder(EnterOrderRq.createUpdateOrderRq(1,security.getIsin(),1,LocalDateTime.now(),Side.BUY,50,1550,1,
                0,20),matcher);
        assertThat(broker1.getCredit()).isEqualTo(100038750);
        assertThat(broker2.getCredit()).isEqualTo(4000000);
    }


    @Test
    void amend_sell_iceberg_order_decreasing_everyThing() throws InvalidRequestException{
        security = Security.builder().isin("MMD").build();
        OrderBook orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new IcebergOrder(1, security, Side.SELL, 45, 1750, broker1, shareholder , 15),
                new Order(2, security, Side.BUY, 7, 1550, broker1, shareholder),
                new Order(3, security, Side.BUY, 100, 1530, broker1, shareholder),
                new Order(4, security, Side.BUY, 45, 1560, broker2, shareholder)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        security.updateOrder(EnterOrderRq.createUpdateOrderRq(1,security.getIsin(),1,LocalDateTime.now(),Side.SELL,50,1600,1,
                0,20),new Matcher());
        broker2.increaseCreditBy(100000000);
        Order order = new Order(7, security, Side.BUY, 450, 1700, broker2, shareholder);
        MatchResult matchResult = matcher.execute(order);
        assertThat(broker1.getCredit()).isEqualTo(100000000);
        assertThat(matchResult.outcome()).isEqualTo(MatchingOutcome.EXECUTED);
        assertThat(matchResult.trades()).isEmpty();
        assertThat(broker2.getCredit()).isEqualTo(99235000);
    }
    
}








