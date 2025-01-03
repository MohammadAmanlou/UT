package ir.ramtung.tinyme.domain.service;

import ir.ramtung.tinyme.domain.entity.*;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.ListIterator;

@Service
public class Matcher {
    
    public MatchResult match(Order newOrder) {
        OrderBook orderBook = newOrder.getSecurity().getOrderBook();
        LinkedList<Trade> trades = new LinkedList<>();

        while (orderBook.hasOrderOfType(newOrder.getSide().opposite()) && newOrder.getQuantity() > 0) {
            Order matchingOrder = orderBook.matchWithFirst(newOrder);
            if (matchingOrder == null)
                break;
            else if ((newOrder instanceof StopLimitOrder) && ((StopLimitOrder) newOrder).getIsActive() == false){
                orderBook.stopLimitOrderEnqueue((StopLimitOrder)newOrder);
                break;
            }

            Trade trade = new Trade(newOrder.getSecurity(), matchingOrder.getPrice(), Math.min(newOrder.getQuantity(), matchingOrder.getQuantity()), newOrder, matchingOrder);
            if (newOrder.getSide() == Side.BUY) {
                if (trade.buyerHasEnoughCredit())
                    trade.decreaseBuyersCredit();
                else {
                    rollbackBuyTrades(newOrder, trades);
                    return MatchResult.notEnoughCredit();
                }
            }
            trade.increaseSellersCredit();
            trades.add(trade);

            if (newOrder.getQuantity() >= matchingOrder.getQuantity()) {
                newOrder.decreaseQuantity(matchingOrder.getQuantity());
                orderBook.removeFirst(matchingOrder.getSide());
                if (matchingOrder instanceof IcebergOrder icebergOrder) {
                    icebergOrder.decreaseQuantity(matchingOrder.getQuantity());
                    icebergOrder.replenish();
                    if (icebergOrder.getQuantity() > 0)
                        orderBook.enqueue(icebergOrder);
                }
                if (matchingOrder instanceof StopLimitOrder stopLimitOrder) {
                    stopLimitOrder.decreaseQuantity(matchingOrder.getQuantity());
                    if (stopLimitOrder.getQuantity() > 0)
                        orderBook.enqueue(stopLimitOrder);
                }
            } else {
                matchingOrder.decreaseQuantity(newOrder.getQuantity());
                newOrder.makeQuantityZero();
            }
        }
        
        if (matchBasedOnMinimumExecutionQuantity(newOrder, trades))
            return MatchResult.executed(newOrder, trades);
        else
            return MatchResult.notEnoughQuantitiesMatched();
    }

    private void rollbackBuyTrades(Order newOrder, LinkedList<Trade> trades) {
        assert newOrder.getSide() == Side.BUY;
        newOrder.getBroker().increaseCreditBy(trades.stream().mapToLong(Trade::getTradedValue).sum());
        trades.forEach(trade -> trade.getSell().getBroker().decreaseCreditBy(trade.getTradedValue()));

        ListIterator<Trade> it = trades.listIterator(trades.size());
        while (it.hasPrevious()) {
            newOrder.getSecurity().getOrderBook().restoreSellOrder(it.previous().getSell());
        }
    }

    private void rollbackSellTrades(Order newOrder, LinkedList<Trade> trades) {
        assert newOrder.getSide() == Side.SELL;
        newOrder.getBroker().decreaseCreditBy(trades.stream().mapToLong(Trade::getTradedValue).sum());
        trades.forEach(trade -> trade.getBuy().getBroker().increaseCreditBy(trade.getTradedValue()));

        ListIterator<Trade> it = trades.listIterator(trades.size());
        while (it.hasPrevious()) {
            newOrder.getSecurity().getOrderBook().restoreBuyOrder(it.previous().getBuy());
        }
    }

    public MatchResult execute(Order order) {
        MatchResult result = match(order);
        if (result.outcome() == MatchingOutcome.NOT_ENOUGH_CREDIT)
            return result;
        if (result.outcome() == MatchingOutcome.NOT_ENOUGH_QUANTITIES_MATCHED)
            return result;

        if (result.remainder().getQuantity() > 0) {
            if (order.getSide() == Side.BUY) {
                if (!order.getBroker().hasEnoughCredit(order.getValue())) {
                    rollbackBuyTrades(order, result.trades());
                    return MatchResult.notEnoughCredit();
                }
                order.getBroker().decreaseCreditBy(order.getValue());
            }
            order.getSecurity().getOrderBook().enqueue(result.remainder());
        }
        if (!result.trades().isEmpty()) {
            for (Trade trade : result.trades()) {
                trade.getBuy().getShareholder().incPosition(trade.getSecurity(), trade.getQuantity());
                trade.getSell().getShareholder().decPosition(trade.getSecurity(), trade.getQuantity());
            }
        }
        return result;
    }

    private boolean matchBasedOnMinimumExecutionQuantity(Order newOrder, LinkedList<Trade> trades) {
        int sumOfTradeQuantities = calculateSumOfTradeQuantities(trades);
        if (newOrder.getMinimumExecutionQuantity() > sumOfTradeQuantities){
            if (newOrder.getSide() == Side.SELL){
                rollbackSellTrades(newOrder, trades);
            }
            else if (newOrder.getSide() == Side.BUY){
                rollbackBuyTrades(newOrder, trades);
            }
            
            
            return false;
        }
        else
            return true;
    }

    private int calculateSumOfTradeQuantities(LinkedList<Trade> trades) {
        return trades.stream()
                 .mapToInt(Trade::getQuantity)
                 .sum();
    }

}
