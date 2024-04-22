package ir.ramtung.tinyme.domain;

import ir.ramtung.tinyme.config.MockedJMSTestConfig;
import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.domain.service.Matcher;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.annotation.DirtiesContext;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Import(MockedJMSTestConfig.class)
@DirtiesContext
public class MatcherTest {
    private Security security;
    private Broker broker;
    private Shareholder shareholder;
    private OrderBook orderBook;
    private List<Order> orders;
    @Autowired
    private Matcher matcher;

    @BeforeEach
    void setupOrderBook() {
        security = Security.builder().build();
        broker = Broker.builder().credit(100_000_000L).build();
        shareholder = Shareholder.builder().build();
        shareholder.incPosition(security, 100_000);
        orderBook = security.getOrderBook();
        orders = Arrays.asList(
            new Order(1, security, Side.BUY, 304, 15700, broker, shareholder),
            new Order(2, security, Side.BUY, 43, 15500, broker, shareholder),
            new Order(3, security, Side.BUY, 445, 15450, broker, shareholder),
            new Order(4, security, Side.BUY, 526, 15450, broker, shareholder),
            new Order(5, security, Side.BUY, 1000, 15400, broker, shareholder),
            new Order(6, security, Side.SELL, 350, 15800, broker, shareholder),
            new Order(7, security, Side.SELL, 285, 15810, broker, shareholder),
            new Order(8, security, Side.SELL, 800, 15810, broker, shareholder),
            new Order(9, security, Side.SELL, 340, 15820, broker, shareholder),
            new Order(10, security, Side.SELL, 65, 15820, broker, shareholder)
        );
        orders.forEach(order -> orderBook.enqueue(order));
    }

    @Test
    void new_sell_order_matches_completely_with_part_of_the_first_buy() {
        Order order = new Order(11, security, Side.SELL, 100, 15600, broker, shareholder);
        Trade trade = new Trade(security, 15700, 100, orders.get(0), order);
        MatchResult result = matcher.match(order);
        assertThat(result.remainder().getQuantity()).isEqualTo(0);
        assertThat(result.trades()).containsExactly(trade);
        assertThat(security.getOrderBook().getBuyQueue().getFirst().getQuantity()).isEqualTo(204);
    }

    @Test
    void new_sell_order_matches_partially_with_the_first_buy() {
        Order order = new Order(11, security, Side.SELL, 500, 15600, broker, shareholder);
        Trade trade = new Trade(security, 15700, 304, orders.get(0), order);
        MatchResult result = matcher.match(order);
        assertThat(result.remainder().getQuantity()).isEqualTo(196);
        assertThat(result.trades()).containsExactly(trade);
        assertThat(security.getOrderBook().getBuyQueue().getFirst().getOrderId()).isEqualTo(2);
    }

    @Test
    void new_sell_order_matches_partially_with_two_buys() {
        Order order = new Order(11, security, Side.SELL, 500, 15500, broker, shareholder);
        Trade trade1 = new Trade(security, 15700, 304, orders.get(0), order);
        Trade trade2 = new Trade(security, 15500, 43, orders.get(1), order.snapshotWithQuantity(196));
        MatchResult result = matcher.match(order);
        assertThat(result.remainder().getQuantity()).isEqualTo(153);
        assertThat(result.trades()).containsExactly(trade1, trade2);
        assertThat(security.getOrderBook().getBuyQueue().getFirst().getOrderId()).isEqualTo(3);
    }

    @Test
    void new_buy_order_matches_partially_with_the_entire_sell_queue() {
        Order order = new Order(11, security, Side.BUY, 2000, 15820, broker, shareholder);
        List<Trade> trades = new ArrayList<>();
        int totalTraded = 0;
        for (Order o : orders.subList(5, 10)) {
            trades.add(new Trade(security, o.getPrice(), o.getQuantity(),
                    order.snapshotWithQuantity(order.getQuantity() - totalTraded), o));
            totalTraded += o.getQuantity();
        }

        MatchResult result = matcher.match(order);
        assertThat(result.remainder().getQuantity()).isEqualTo(160);
        assertThat(result.trades()).isEqualTo(trades);
        assertThat(security.getOrderBook().getSellQueue()).isEmpty();
    }

    @Test
    void new_buy_order_does_not_match() {
        Order order = new Order(11, security, Side.BUY, 2000, 15500, broker, shareholder);
        MatchResult result = matcher.match(order);
        assertThat(result.remainder()).isEqualTo(order);
        assertThat(result.trades()).isEmpty();
    }

    @Test
    void iceberg_order_in_queue_matched_completely_after_three_rounds() {
        security = Security.builder().build();
        broker = Broker.builder().build();
        orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new IcebergOrder(1, security, Side.BUY, 450, 15450, broker, shareholder, 200),
                new Order(2, security, Side.BUY, 70, 15450, broker, shareholder),
                new Order(3, security, Side.BUY, 1000, 15400, broker, shareholder)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        Order order = new Order(4, security, Side.SELL, 600, 15450, broker, shareholder);
        List<Trade> trades = List.of(
                new Trade(security, 15450, 200, orders.get(0).snapshotWithQuantity(200), order.snapshotWithQuantity(600)),
                new Trade(security, 15450, 70, orders.get(1).snapshotWithQuantity(70), order.snapshotWithQuantity(400)),
                new Trade(security, 15450, 200, orders.get(0).snapshotWithQuantity(200), order.snapshotWithQuantity(330)),
                new Trade(security, 15450, 50, orders.get(0).snapshotWithQuantity(50), order.snapshotWithQuantity(130))
        );

        MatchResult result = matcher.match(order);

        assertThat(result.remainder().getQuantity()).isEqualTo(80);
        assertThat(result.trades()).isEqualTo(trades);
    }
}
