package ir.ramtung.tinyme.domain;

import ir.ramtung.tinyme.config.MockedJMSTestConfig;
import ir.ramtung.tinyme.domain.entity.*;
import ir.ramtung.tinyme.domain.service.Matcher;
import ir.ramtung.tinyme.domain.service.OrderHandler;
import ir.ramtung.tinyme.messaging.EventPublisher;
import ir.ramtung.tinyme.messaging.Message;
import ir.ramtung.tinyme.messaging.TradeDTO;
import ir.ramtung.tinyme.messaging.event.OpeningPriceEvent;
import ir.ramtung.tinyme.messaging.event.OrderAcceptedEvent;
import ir.ramtung.tinyme.messaging.event.OrderActivatedEvent;
import ir.ramtung.tinyme.messaging.event.OrderExecutedEvent;
import ir.ramtung.tinyme.messaging.event.OrderRejectedEvent;
import ir.ramtung.tinyme.messaging.event.OrderUpdatedEvent;
import ir.ramtung.tinyme.messaging.event.SecurityStateChangedEvent;
import ir.ramtung.tinyme.messaging.event.TradeEvent;
import ir.ramtung.tinyme.messaging.request.ChangeMatchStateRq;
import ir.ramtung.tinyme.messaging.request.DeleteOrderRq;
import ir.ramtung.tinyme.messaging.request.EnterOrderRq;
import ir.ramtung.tinyme.messaging.request.MatchingState;
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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import static ir.ramtung.tinyme.domain.entity.Side.BUY;
import static ir.ramtung.tinyme.domain.entity.Side.SELL;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

@SpringBootTest
@Import(MockedJMSTestConfig.class)
@DirtiesContext
public class AuctionMatchingTest {
    private Security security;
    private Broker broker1;
    private Broker broker2;
    private Shareholder shareholder;
    private OrderBook orderBook;
    private List<Order> orders;
    @Autowired
    private Matcher matcher;
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

    @BeforeEach
    void setup() {
        security = Security.builder().isin("ABC").build();
        securityRepository.addSecurity(security);
        broker1 = Broker.builder().brokerId(1).credit(100_000_000L).build();
        broker2 = Broker.builder().brokerId(2).credit(100_000_000L).build();
        brokerRepository.addBroker(broker1);
        brokerRepository.addBroker(broker2);
        shareholder = Shareholder.builder().build();
        shareholderRepository.addShareholder(shareholder);
        shareholder.incPosition(security, 100_000);
        orderBook = security.getOrderBook();
        orders = Arrays.asList(
                new Order(1, security, Side.BUY, 304, 15700, broker1, shareholder,0),
                new Order(2, security, Side.BUY, 43, 15500, broker1, shareholder,0),
                new Order(3, security, Side.BUY, 445, 15450, broker1, shareholder,0),
                new Order(4, security, Side.BUY, 526, 15450, broker1, shareholder,0),
                new Order(5, security, Side.BUY, 1000, 15400, broker1, shareholder,0),
                new Order(6, security, Side.SELL, 350, 15800, broker2, shareholder,0),
                new Order(7, security, Side.SELL, 285, 15490, broker2, shareholder,0),
                new Order(8, security, Side.SELL, 800, 15810, broker2, shareholder,0),
                new Order(9, security, Side.SELL, 340, 15820, broker2, shareholder,0),
                new Order(10, security, Side.SELL, 65, 15820, broker2, shareholder,0)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        System.out.println(orderBook);
    }
    
    @Test
    void find_auction_price_successfully_done(){ //checked
       int openingPrice = security.updateIndicativeOpeningPrice();
       assertThat(openingPrice).isEqualTo(15490);
    }

    @Test
    void find_auction_price_successfully_done_when_some_orders_get_removed() { //checked
        orderBook.removeByOrderId(Side.SELL, 10);
        orderBook.removeByOrderId(Side.SELL, 9);
        int openingPrice = security.updateIndicativeOpeningPrice();
        assertThat(openingPrice).isEqualTo(15490);
    }

    @Test
    void default_match_state_is_continuous() {   //checked
        assertThat(security.getMatchingState()).isEqualTo(MatchingState.CONTINUOUS);
    }

    @Test
    void change_match_state_from_continuous_to_auction() { //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        assertThat(security.getMatchingState()).isEqualTo(MatchingState.AUCTION);
        verify(eventPublisher).publish(new SecurityStateChangedEvent( security.getIsin() , MatchingState.AUCTION));
    }

     @Test
     void no_opening_price_for_new_orders() { //checked
        orders.forEach(order -> orderBook.removeByOrderId(order.getSide() , order.getOrderId()));
        orders = Arrays.asList(
                new Order(11, security, BUY, 304, 15700, broker1, shareholder,0),
                new Order(12, security, BUY, 43, 15500, broker1, shareholder,0),
                new Order(13, security, SELL, 350, 15800, broker2, shareholder,0),
                new Order(14, security, SELL, 1000, 15820, broker2, shareholder,0)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        int openingPrice = security.updateIndicativeOpeningPrice();
        assertThat(openingPrice).isEqualTo(0);
     }


     @Test
     void opening_price_calculated_successfully_when_opening_price_is_on_boundary() { //checked
        orders.forEach(order -> orderBook.removeByOrderId(order.getSide() , order.getOrderId()));
        orders = Arrays.asList(
                new Order(1, security, BUY, 304, 15700, broker1, shareholder,0),
                new Order(2, security, BUY, 1000, 15400, broker1, shareholder,0),
                new Order(3, security, SELL, 350, 15700, broker2, shareholder,0),
                new Order(4, security, SELL, 65, 15820, broker2, shareholder,0)
        );
        orders.forEach(order -> orderBook.enqueue(order));
        int openingPrice = security.updateIndicativeOpeningPrice();
        assertThat(openingPrice).isEqualTo(15700);
     }

    @Test 
    void adding_new_iceberg_order_in_auction_state_successfully_done(){ //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), Side.BUY, 30, 500,
            broker1.getBrokerId(), shareholder.getShareholderId(), 20, 0 , 0));
        verify(eventPublisher).publish(new OrderAcceptedEvent(1, 200));
        verify(eventPublisher).publish(new OpeningPriceEvent(security.getIsin() , 15490 , 285));
    }

    @Test 
    void adding_new_order_in_auction_state_successfully_done(){ //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), Side.BUY, 30, 500,
            broker1.getBrokerId(), shareholder.getShareholderId(), 0, 0 , 0));
        verify(eventPublisher).publish(new OrderAcceptedEvent(1, 200));
        verify(eventPublisher).publish(new OpeningPriceEvent(security.getIsin() , 15490 , 285));
    }

    @Test
    void change_match_state_from_continuous_to_continuous(){ //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.CONTINUOUS));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.CONTINUOUS));
    }
     
    @Test
    void default_opening_price_equals_to_zero(){ //checked
        orders.forEach(order -> orderBook.removeByOrderId(order.getSide() , order.getOrderId()));
        int openingPrice = security.updateIndicativeOpeningPrice();
        assertThat(openingPrice).isEqualTo(0);
    }

    @Test
    void one_side_orders_opening_price_equals_to_zero(){ //checked
        orderBook.removeByOrderId(Side.SELL, 6);
        orderBook.removeByOrderId(Side.SELL, 7);
        orderBook.removeByOrderId(Side.SELL, 8);
        orderBook.removeByOrderId(Side.SELL, 9);
        orderBook.removeByOrderId(Side.SELL, 10);
       int openingPrice = security.updateIndicativeOpeningPrice();
       assertThat(openingPrice).isEqualTo(0);
    }

    @Test
    void find_auction_price_successfully_done_when_some_sell__orders_get_price_updated() { //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 7, LocalDateTime.now(), Side.SELL, 
        285, 15500, broker2.getBrokerId(), shareholder.getShareholderId(), 0, 0 , 0));
        verify(eventPublisher).publish(new OrderUpdatedEvent(1, 7));
        verify(eventPublisher).publish(new OpeningPriceEvent(security.getIsin() , 15500 , 285));
    }

    @Test 
    void change_match_state_from_auction_to_continuous(){ //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.CONTINUOUS));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.CONTINUOUS));
        verify(eventPublisher).publish(new OpeningPriceEvent(security.getIsin() , 15490 , 285));
        verify(eventPublisher).publish(new TradeEvent(security.getIsin() , 15490 , 285 , 1 , 7));
        assertThat(broker1.getCredit()).isEqualTo(100059850L);
        assertThat(broker2.getCredit()).isEqualTo(104414650L);
    }

    @Test
    void deleting_inactive_stop_limit_order_in_auction_state_successfully_rejected(){ //checked
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(),
                Side.BUY, 10, 100, broker1.getBrokerId(), shareholder.getShareholderId(),
                0 , 0 , 200));
        verify(eventPublisher).publish(new OrderAcceptedEvent(1 , 200));
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
        orderHandler.handleDeleteOrder(new DeleteOrderRq(2, security.getIsin(), Side.BUY, 200));
        verify(eventPublisher).publish(new OrderRejectedEvent(2, 200, List.of(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_CANT_REMOVE)));
    }

    @Test
    void updating_inactive_stop_limit_order_in_auction_state_successfully_rejected(){ //checked
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(),
                Side.BUY, 10, 100, broker1.getBrokerId(), shareholder.getShareholderId(),
                0 , 0 , 200));
        verify(eventPublisher).publish(new OrderAcceptedEvent(1 , 200));
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(2, "ABC", 200, LocalDateTime.now(),
                Side.BUY, 10, 150, broker1.getBrokerId(), shareholder.getShareholderId(),
                0 , 0 , 200));
        verify(eventPublisher).publish(new OrderRejectedEvent(2, 200, List.of(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_CANT_UPDATE)));
    }

     @Test
     void stop_limit_order_is_activated_after_one_buy_order_and_opening_price_get_zero_for_it_in_auction_matching_state(){ //checked
        orderBook.setLastTradePrice(17000);
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(3, "ABC", 400, LocalDateTime.now(), 
         Side.SELL, 10, 16000, broker2.getBrokerId(), shareholder.getShareholderId(), 
         0 , 0 , 16000));
         verify(eventPublisher).publish(new OrderAcceptedEvent(3, 400));
         orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
         verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
         orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(5, "ABC", 600, LocalDateTime.now(), 
         Side.BUY , 350, 15900, broker1.getBrokerId(), shareholder.getShareholderId(), 
         0 , 0 ));
         verify(eventPublisher).publish(new OrderAcceptedEvent(5, 600));
         orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
         verify(eventPublisher , times(2)).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
         verify(eventPublisher).publish(new OpeningPriceEvent("ABC", 15900, 350));
         verify(eventPublisher).publish(new OrderActivatedEvent(3, 400));
         verify(eventPublisher).publish(new TradeEvent("ABC" , 15900 , 285 , 600 , 7));
         verify(eventPublisher).publish(new TradeEvent("ABC" , 15900 , 65 , 600 , 6));
         assertThat(broker1.getCredit()).isEqualTo(94435000L );
         assertThat(broker2.getCredit()).isEqualTo(105565000L );
         int openingPrice = security.updateIndicativeOpeningPrice();
         assertThat(openingPrice).isEqualTo(0);
     } 

     @Test
     void stop_limit_order_is_activated_after_one_buy_order_and_opening_price_get_calculated_for_it_in_auction_matching_state(){ //checked
        orderBook.setLastTradePrice(17000);
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(3, "ABC", 400, LocalDateTime.now(), 
         Side.SELL, 10, 15000, broker2.getBrokerId(), shareholder.getShareholderId(), 
         0 , 0 , 16000));
         verify(eventPublisher).publish(new OrderAcceptedEvent(3, 400));
         orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
         verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
         orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(5, "ABC", 600, LocalDateTime.now(), 
         Side.BUY , 350, 15900, broker1.getBrokerId(), shareholder.getShareholderId(), 
         0 , 0 ));
         verify(eventPublisher).publish(new OrderAcceptedEvent(5, 600));
         orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
         verify(eventPublisher , times(2)).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
         verify(eventPublisher).publish(new OpeningPriceEvent("ABC", 15900, 350));
         verify(eventPublisher).publish(new OrderActivatedEvent(3, 400));
         verify(eventPublisher).publish(new TradeEvent("ABC" , 15900 , 285 , 600 , 7));
         verify(eventPublisher).publish(new TradeEvent("ABC" , 15900 , 65 , 600 , 6));
         assertThat(broker1.getCredit()).isEqualTo(94435000L );
         assertThat(broker2.getCredit()).isEqualTo(105565000L );
         int openingPrice = security.updateIndicativeOpeningPrice();
         assertThat(openingPrice).isEqualTo(15700);
     } 

     @Test
     void can_not_add_buy_order_with_MEQ_in_auction_matching_state(){ // checked
         orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
         verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
         orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
         Side.BUY, 50, 550, broker1.getBrokerId(), shareholder.getShareholderId(), 10,40));
         verify(eventPublisher).publish(new OrderRejectedEvent(1, 100, List.of(Message.MEQ_IS_PROHIBITED_IN_AUCTION_MODE)));
     }
 
     @Test
     void can_not_add_sell_order_with_MEQ_in_auction_matching_state(){ //checked
         orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
         verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
         orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
         Side.SELL, 50, 550, broker1.getBrokerId(), shareholder.getShareholderId(), 10,40));
         verify(eventPublisher).publish(new OrderRejectedEvent(1, 100, List.of(Message.MEQ_IS_PROHIBITED_IN_AUCTION_MODE)));
     }
 
     
     @Test
     void many_opening_prices_available_but_the_one_that_is_closer_to_last_trade_prices_gets_accepted(){  //checked
         orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 200, LocalDateTime.now(), 
         Side.SELL, 10, 900, broker2.getBrokerId(), shareholder.getShareholderId(), 
         0 , 0 , 0));
         verify(eventPublisher).publish(new OrderAcceptedEvent(2, 200));
         double lastTradePrice = orderBook.getLastTradePrice();
         int openingPrice = security.updateIndicativeOpeningPrice();
         assertThat(openingPrice).isEqualTo(15700);
         assertThat(lastTradePrice).isEqualTo(15700);
     } 

     @Test
     void many_opening_prices_available_but_the_one_that_is_closer_to_last_trade_prices_gets_accepted_with_more_trade_quantity_remaining(){  //checked
         orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 200, LocalDateTime.now(), 
         Side.SELL, 20, 900, broker2.getBrokerId(), shareholder.getShareholderId(), 
         0 , 0 , 0));
         verify(eventPublisher).publish(new OrderAcceptedEvent(2, 200));
         double lastTradePrice = orderBook.getLastTradePrice();
         int openingPrice = security.updateIndicativeOpeningPrice();
         assertThat(openingPrice).isEqualTo(15500);
         assertThat(lastTradePrice).isEqualTo(15700);
     } 

    @Test
    void no_trade_happens_in_auction_matching_state() { //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent(security.getIsin() , MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 400, LocalDateTime.now(), 
        Side.BUY, 10, 700, broker1.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 )); 
        verify(eventPublisher).publish(new OpeningPriceEvent("ABC", 15490, 285));
        verify(eventPublisher).publish(new OrderAcceptedEvent(2, 400));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), 
        Side.BUY, 10, 700, broker1.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 0));
        assertThat(broker1.getCredit()).isEqualTo(99_986_000L);
        assertThat(broker2.getCredit()).isEqualTo(100_000_000L);
        verify(eventPublisher).publish(new OrderAcceptedEvent(2, 400));
        verify(eventPublisher).publish(new OrderAcceptedEvent(1, 200));
        verify(eventPublisher ,times(2)).publish(new OpeningPriceEvent(security.getIsin(),15490,285)); 
    }

    @Test
    void change_match_state_from_auction_to_auction() { //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent("ABC", MatchingState.AUCTION));
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher , times(2)).publish(new SecurityStateChangedEvent("ABC", MatchingState.AUCTION));
        verify(eventPublisher).publish(new OpeningPriceEvent(security.getIsin(),15490 , 285));
        assertThat(broker1.getCredit()).isEqualTo(100_000_000 + 285*15700 - 285 * 15490 );
        verify(eventPublisher).publish(new TradeEvent("ABC",15490,285,1,7));  
    }

    @Test
    void find_auction_price_successfully_done_when_buy_order_get_deleted() { //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent("ABC", MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
        Side.BUY, 20, 900, broker1.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 0));
        verify(eventPublisher).publish(new OrderAcceptedEvent(1, 100));
        verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15490,285));
        double lastTradePrice = orderBook.getLastTradePrice();
        int openingPrice = security.updateIndicativeOpeningPrice();
        assertThat(openingPrice).isEqualTo(15490);
        orderHandler.handleDeleteOrder(new DeleteOrderRq(2,"ABC",Side.BUY,100));
        verify(eventPublisher , times(2)).publish(new OpeningPriceEvent("ABC",15490,285));
        
    }
    
    @Test
    void find_auction_price_successfully_done_when_sell_order_get_deleted() { //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
        Side.SELL, 20, 900, broker1.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 0));
        verify(eventPublisher).publish(new OrderAcceptedEvent(1,100));
        verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15490,305));
        orderHandler.handleDeleteOrder(new DeleteOrderRq(2,"ABC",Side.SELL,100));
        verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15490,285));
        
    }
    @Test
    void in_auction_state_new_orders_comes_to_queue_and_new_opening_price_doese_not_change_because_trade_price_doese_not_change(){ //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
        Side.BUY, 20, 900, broker1.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 0));
        verify(eventPublisher).publish(new OrderAcceptedEvent(1,100));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 200, LocalDateTime.now(), 
        Side.SELL, 20, 900, broker2.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 0));
        verify(eventPublisher).publish(new OrderAcceptedEvent(2,200));
        verify(eventPublisher).publish(new OpeningPriceEvent("ABC", 15490,285));
        verify(eventPublisher).publish(new OpeningPriceEvent("ABC", 15490,305));
    }
   
   @Test
   void trading_happens_in_auction_to_auction_and_opening_price_update_successfully(){ // checked
      orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
      
      orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 11, LocalDateTime.now(), 
          Side.BUY, 30, 15000, broker1.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
      orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 12, LocalDateTime.now(), 
          Side.BUY, 20, 14000, broker1.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
      orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(3, "ABC", 13, LocalDateTime.now(), 
          Side.SELL, 10, 15800, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
      assertThat(security.getIndicativeOpeningPrice()).isEqualTo(15490);
      verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION));
      verify(eventPublisher , times(3)).publish(new OpeningPriceEvent("ABC",15490,285)); 
      verify(eventPublisher).publish(new OrderAcceptedEvent(1,11));
      verify(eventPublisher).publish(new OrderAcceptedEvent(2,12));
      verify(eventPublisher).publish(new OrderAcceptedEvent(3,13));
      assertThat(security.getIndicativeOpeningPrice()).isEqualTo(15490);
   }

   @Test
   void trading_happens_in_auction_to_auction_and_(){ 
      orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
      orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 11, LocalDateTime.now(), 
          Side.BUY, 30, 15000, broker1.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
      orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 12, LocalDateTime.now(), 
          Side.BUY, 20, 14000, broker1.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
      orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(3, "ABC", 13, LocalDateTime.now(), 
          Side.SELL, 10, 15400, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
      assertThat(broker1.getCredit()).isEqualTo(99270000);
      assertThat(broker2.getCredit()).isEqualTo(100000000);
      orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
   }

  @Test
  void update_price_for_buy_order_in_auction_state_successful() { // chcked
      orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
      orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 10, 
          LocalDateTime.now(), Side.SELL, 65, 16000, broker2.getBrokerId(), shareholder.getShareholderId(), 0, 0 , 0));
      assertThat(security.getOrderBook().findByOrderId(Side.SELL , 10).getPrice()).isEqualTo(16000);
      verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION)); 
      verify(eventPublisher).publish(new OrderUpdatedEvent(1,10));
      verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15490,285)); 
  }

  @Test
  void add_new_order_in_auction_and_tradable_quantity_does_not_change(){ // checked
      orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
      orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 11, LocalDateTime.now(), 
          Side.BUY, 300, 15400, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
      security.getOrderBook().setLastTradePrice(10000);
      assertThat(security.getHighestQuantity()).isEqualTo(285);
      verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION)); 
      verify(eventPublisher).publish(new OrderAcceptedEvent(1,11));
      verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15490,285)); 
  }
   
   @Test
   void add_new_order_in_auction_and_tradable_quantity_does_change(){ // checked
       assertThat(security.getHighestQuantity()).isEqualTo(0);
       orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
       assertThat(security.getHighestQuantity()).isEqualTo(285);
       orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 11, LocalDateTime.now(), 
           Side.BUY, 300, 15800, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
       security.getOrderBook().setLastTradePrice(10000);
       verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION)); 
       assertThat(security.getHighestQuantity()).isEqualTo(300);
       verify(eventPublisher).publish(new OrderAcceptedEvent(1,11));
       verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15800,300));   
   }

   @Test
   void add_new_iceberg_order_in_auction_and_find_tradable_quantity_new_order_without_impact_successfully_done(){ //checked
        security.getOrderBook().setLastTradePrice(10000);
       orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
       verify(eventPublisher).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
       orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 11, LocalDateTime.now(), 
           Side.BUY, 101, 15800, broker1.getBrokerId(), shareholder.getShareholderId(), 100 , 0 , 0));
       verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15490,285)); 
       verify(eventPublisher).publish(new OrderAcceptedEvent(1 , 11)); 
   }

   @Test
   void add_new_iceberg_order_in_auction_and_find_tradable_quantity_successfully_done(){ //checked
       security.getOrderBook().setLastTradePrice(100000);
       orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
       orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 11, LocalDateTime.now(), 
           Side.BUY, 285, 15800, broker1.getBrokerId(), shareholder.getShareholderId(), 100 , 0 , 0));
       assertThat(security.getHighestQuantity()).isEqualTo(285);
       assertThat(security.getIndicativeOpeningPrice()).isEqualTo(15800);
       verify(eventPublisher).publish(new OrderAcceptedEvent(1,11));
       verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15800,285)); 
       verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION));   }
  
      

   @Test
   void adding_buy_stop_limit_order_in_auction_matching_state_successfully_rejected(){ // checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
          Side.BUY, 40, 500, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 300));
        verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION));
        verify(eventPublisher).publish(new OrderRejectedEvent(1,100,List.of(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_ERROR)));
   }
   
    @Test
    void adding_sell_stop_limit_order_in_auction_matching_state_successfully_rejected(){ // checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 200, LocalDateTime.now(), 
        Side.SELL, 10, 900, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 300));
        verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION));
        verify(eventPublisher).publish(new OrderRejectedEvent(1,200,List.of(Message.STOPLIMIT_ORDER_IN_AUCTION_MODE_ERROR)));
    }

 @Test
 void update_quantity_for_buy_order_in_auction_state_successfully_done() { // checked

     orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
     orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 2, 
         LocalDateTime.now(), Side.BUY, 100, 15500, broker1.getBrokerId(), shareholder.getShareholderId(), 0, 0 , 0));
     assertThat(security.getIndicativeOpeningPrice()).isEqualTo(15490);
     verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION));
     verify(eventPublisher).publish(new OrderUpdatedEvent(1,2));
     verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15490,285));    }

 @Test
 void update_quantity_for_sell_order_in_auction_state_successfully_done() { //checked
     orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
     orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 7, 
         LocalDateTime.now(), Side.SELL, 2, 15490, broker1.getBrokerId(), shareholder.getShareholderId(), 0, 0 , 0));
     assertThat(security.getIndicativeOpeningPrice()).isEqualTo(15490);
     verify(eventPublisher ).publish(new SecurityStateChangedEvent("ABC",MatchingState.AUCTION));
     verify(eventPublisher).publish(new OrderUpdatedEvent(1,7));
     verify(eventPublisher).publish(new OpeningPriceEvent("ABC",15490,2));
 }
 

    @Test
    void one_buy_order_entered_shareholder_doese_not_have_enough_position(){  //checked
        shareholder.decPosition(security, 100_000);
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
        Side.SELL, 20000000, 900, broker1.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 0));
        verify(eventPublisher).publish(new OrderRejectedEvent(1,100, List.of(Message.SELLER_HAS_NOT_ENOUGH_POSITIONS)));
    }
 
 @Test
    void one_sell_order_entered_shareholder_doese_not_have_enough_position(){ //checked
        shareholder.decPosition(security, 100_000);
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
        Side.SELL, 20, 900, broker1.getBrokerId(), shareholder.getShareholderId(), 
        0 , 0 , 0));
        verify(eventPublisher).publish(new OrderRejectedEvent(1,100, List.of(Message.SELLER_HAS_NOT_ENOUGH_POSITIONS)));
 }

    @Test
    void can_not_update_buy_order_with_MEQ_in_auction_matching_state(){ //checked
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
        Side.BUY, 50, 550, broker1.getBrokerId(), shareholder.getShareholderId(), 0,40));
        orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 100, LocalDateTime.now(), Side.BUY, 50, 16000,
        broker1.getBrokerId(), shareholder.getShareholderId(), 0, 0 ));
        verify(eventPublisher).publish(new OrderRejectedEvent(1, 100, List.of(Message.MEQ_IS_PROHIBITED_IN_AUCTION_MODE)));
        verify(eventPublisher).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
  }

  @Test
  void can_not_update_sell_order_with_MEQ_in_auction_matching_state(){ // checked
     orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
     orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 100, LocalDateTime.now(), 
     Side.SELL, 50, 550, broker1.getBrokerId(), shareholder.getShareholderId(), 0,40));
     orderHandler.handleEnterOrder(EnterOrderRq.createUpdateOrderRq(1, "ABC", 100, LocalDateTime.now(), Side.SELL, 50, 1000,
            broker1.getBrokerId(), shareholder.getShareholderId(), 0, 0 ));
     verify(eventPublisher).publish(new OrderRejectedEvent(1, 100, List.of(Message.MEQ_IS_PROHIBITED_IN_AUCTION_MODE)));
     verify(eventPublisher).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
 }
  
  @Test
 void three_times_changing_matching_state_and_publishing_opening_price_event_after_that(){ // checked
     orders.forEach(order -> orderBook.removeByOrderId(order.getSide(), order.getOrderId()));
     orders = Arrays.asList(
             new Order(1, security, Side.SELL, 200, 16000, broker2, shareholder, 0),
             new Order(2, security, Side.BUY, 300, 16000, broker1, shareholder, 0)
             );
     orders.forEach(order -> orderBook.enqueue(order));
     orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
     verify(eventPublisher).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
     orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(1, "ABC", 3, LocalDateTime.now(), 
         Side.SELL, 100, 16000, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
     verify(eventPublisher).publish(new OrderAcceptedEvent(1, 3));
     orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
     verify(eventPublisher,times(2)).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
     orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
     verify(eventPublisher,times(3)).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
     orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(2, "ABC", 4, LocalDateTime.now(), 
         Side.SELL, 285, 15815, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
     verify(eventPublisher).publish(new OrderAcceptedEvent(2, 4));
     orderHandler.handleEnterOrder(EnterOrderRq.createNewOrderRq(3, "ABC", 5, LocalDateTime.now(), 
         Side.SELL, 285, 15800, broker2.getBrokerId(), shareholder.getShareholderId(), 0 , 0 , 0));
     verify(eventPublisher).publish(new OrderAcceptedEvent(3, 5));
     verify(eventPublisher,times(2)).publish(new OpeningPriceEvent("ABC", 16000, 300));
     verify(eventPublisher).publish(new TradeEvent("ABC", 16000, 200,2,1));
     verify(eventPublisher).publish(new TradeEvent("ABC", 16000, 100,2,3));
     verify(eventPublisher,times(2)).publish(new OpeningPriceEvent("ABC", 0, 0));
     verify(eventPublisher).publish(new OpeningPriceEvent("ABC", 0, 300));
 }
    @Test
    void check_auction_match_with_given_opening_price_with_one_buy_icebergOrder(){ //checked
        orders.forEach(order -> orderBook.removeByOrderId(order.getSide(), order.getOrderId()));
        orders = Arrays.asList(
                new Order(1, security, Side.BUY, 304, 15700, broker1, shareholder, 0),
                new IcebergOrder(3 , security , Side.BUY , 200 , 15650 , broker1 ,shareholder , 50, 0),
                new Order(2, security, Side.BUY, 43, 15600, broker1, shareholder, 0),
                new Order(9, security, Side.SELL, 340, 15400, broker2, shareholder, 0),
                new Order(10, security, Side.SELL, 65, 15500, broker2, shareholder, 0)
                );
        orders.forEach(order -> orderBook.enqueue(order));
        orderBook.setLastTradePrice(15550);
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher,times(1)).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
        int openingPrice = security.getIndicativeOpeningPrice();
        assertThat(openingPrice).isEqualTo(15550);
        orderHandler.handleChangeMatchStateRq(ChangeMatchStateRq.changeMatchStateRq(security.getIsin(), MatchingState.AUCTION));
        verify(eventPublisher,times(2)).publish(new SecurityStateChangedEvent( "ABC",MatchingState.AUCTION));
        verify(eventPublisher).publish(new OpeningPriceEvent("ABC", 15550, 405));
        verify(eventPublisher).publish(new TradeEvent("ABC", 15550, 304, 1, 9));
        verify(eventPublisher).publish(new TradeEvent("ABC", 15550, 36, 3, 9));
        verify(eventPublisher).publish(new TradeEvent("ABC", 15550, 14, 3, 10));
        verify(eventPublisher).publish(new TradeEvent("ABC", 15550, 1, 3, 10));
        assertThat(broker1.getCredit()).isEqualTo(100_000_000L + 304 * (15700 - 15550) +  101 * (15650 - 15550));
        assertThat(broker2.getCredit()).isEqualTo(100_000_000L + 405 * (15550));
        assertThat(security.getOrderBook().getBuyQueue().size()).isEqualTo(2);
        assertThat(security.getOrderBook().getBuyQueue().getFirst().getOrderId()).isEqualTo(3);
        assertThat(security.getOrderBook().getSellQueue().size()).isEqualTo(0);
    }
}
