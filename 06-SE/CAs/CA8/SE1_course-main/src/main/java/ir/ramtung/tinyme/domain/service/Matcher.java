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
        processOrderBook(newOrder, orderBook, trades);
        return finalizeMatch(newOrder, trades);
    }

    private void processOrderBook(Order newOrder, OrderBook orderBook, LinkedList<Trade> trades) {
        while (orderBook.hasOrderOfType(newOrder.getSide().opposite()) && newOrder.getQuantity() > 0) {
            Order matchingOrder = orderBook.matchWithFirst(newOrder);
            if (matchingOrder == null)
                break;

            Trade trade = createTrade(newOrder, matchingOrder);
            if (newOrder.getSide() == Side.BUY) {
                if (!processBuyTrade(newOrder, trades, trade))
                    return;
            }
            trade.increaseSellersCredit();
            trades.add(trade);
            updateOrderQuantities(newOrder, orderBook, matchingOrder);
        }
    }

    private Trade createTrade(Order newOrder, Order matchingOrder) {
        return new Trade(newOrder.getSecurity(), matchingOrder.getPrice(),
                Math.min(newOrder.getQuantity(), matchingOrder.getQuantity()), newOrder, matchingOrder);
    }

    private boolean processBuyTrade(Order newOrder, LinkedList<Trade> trades, Trade trade) {
        if (trade.buyerHasEnoughCredit()) {
            trade.decreaseBuyersCredit();
            return true;
        } else {
            rollbackBuyTrades(newOrder, trades);
            return false;
        }
    }

    private void updateOrderQuantities(Order newOrder, OrderBook orderBook, Order matchingOrder) {
        if (newOrder.getQuantity() >= matchingOrder.getQuantity()) {
            newOrder.decreaseQuantity(matchingOrder.getQuantity());
            orderBook.removeFirst(matchingOrder.getSide());
            if (matchingOrder instanceof IcebergOrder icebergOrder) {
                icebergOrder.decreaseQuantity(matchingOrder.getQuantity());
                icebergOrder.replenish();
                if (icebergOrder.getQuantity() > 0)
                    orderBook.enqueue(icebergOrder);
            }
        } else {
            matchingOrder.decreaseQuantity(newOrder.getQuantity());
            newOrder.makeQuantityZero();
        }
    }

    private MatchResult finalizeMatch(Order newOrder, LinkedList<Trade> trades) {
        if (matchBasedOnMinimumExecutionQuantity(newOrder, trades)) {
            return MatchResult.executed(newOrder, trades);
        } else {
            return MatchResult.notEnoughQuantitiesMatched();
        }
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

    public MatchResult auctionAddToQueue(Order order) {
        MatchResult creditResult = checkBuyerCreditIfNeeded(order);
        if (creditResult != null)
            return creditResult;

        MatchResult positionResult = checkSellerPositionsIfNeeded(order);
        if (positionResult != null)
            return positionResult;

        enqueueOrderAndUpdatePrice(order);
        return MatchResult.orderEnqueuedAuction();
    }

    private MatchResult checkBuyerCreditIfNeeded(Order order) {
        if (order.getSide() == Side.BUY) {
            return checkBuyerCredit(order);
        }
        return null;
    }

    private MatchResult checkSellerPositionsIfNeeded(Order order) {
        if (order.getSide() == Side.SELL) {
            return checkSellerPositions(order);
        }
        return null;
    }

    private MatchResult checkBuyerCredit(Order order) {
        if (!order.getBroker().hasEnoughCredit(order.getValue())) {
            return MatchResult.notEnoughCredit();
        }
        order.getBroker().decreaseCreditBy(order.getValue());
        return null;
    }

    private MatchResult checkSellerPositions(Order order) {
        if (!order.getShareholder().hasEnoughPositionsOn(order.getSecurity(), order.getQuantity())) {
            return MatchResult.notEnoughPositions();
        }
        return null;
    }

    private void enqueueOrderAndUpdatePrice(Order order) {
        order.getSecurity().getOrderBook().enqueue(order);
        order.getSecurity().updateIndicativeOpeningPrice();
    }

    public MatchResult execute(Order order) {
        MatchResult result = match(order);
        if (isMatchingOutcomeNotEnough(result))
            return result;

        result = processRemainder(order, result);
        updateLastTradePriceAndPositions(order, result);
        return result;
    }

    public MatchResult auctionExecute(Order order, int indicativeOpeningPrice) {
        MatchResult result = auctionMatch(order, indicativeOpeningPrice);
        if (isMatchingOutcomeNotEnough(result))
            return result;

        result = processRemainderForAuction(order, result);
        updateLastTradePriceAndPositions(order, result);
        return result;
    }

    private boolean isMatchingOutcomeNotEnough(MatchResult result) {
        return result.outcome() == MatchingOutcome.NOT_ENOUGH_CREDIT
                || result.outcome() == MatchingOutcome.NOT_ENOUGH_QUANTITIES_MATCHED;
    }

    private MatchResult processRemainder(Order order, MatchResult result) {
        if (result.remainder().getQuantity() > 0) {
            if (order.getSide() == Side.BUY) {
                if (!order.getBroker().hasEnoughCredit(order.getValue()) && !(order instanceof StopLimitOrder)) {
                    rollbackBuyTrades(order, result.trades());
                    return MatchResult.notEnoughCredit();
                }
                order.getBroker().decreaseCreditBy(order.getValue());
            }
            order.getSecurity().getOrderBook().enqueue(result.remainder());
        }
        return result;
    }

    private MatchResult processRemainderForAuction(Order order, MatchResult result) {
        if (result.remainder().getQuantity() > 0) {
            order.getSecurity().getOrderBook().enqueue(result.remainder());
        }
        return result;
    }

    private void updateLastTradePriceAndPositions(Order order, MatchResult result) {
        if (!result.trades().isEmpty()) {
            order.getSecurity().getOrderBook().setLastTradePrice(result.trades().getLast().getPrice());
            for (Trade trade : result.trades()) {
                trade.getBuy().getShareholder().incPosition(trade.getSecurity(), trade.getQuantity());
                trade.getSell().getShareholder().decPosition(trade.getSecurity(), trade.getQuantity());
            }
        }
    }

    public MatchResult auctionMatch(Order newOrder, int indicativeOpeningPrice) {
        OrderBook orderBook = newOrder.getSecurity().getOrderBook();
        LinkedList<Trade> trades = new LinkedList<>();
        processAuctionOrderBook(newOrder, orderBook, trades, indicativeOpeningPrice);
        return finalizeAuctionMatch(newOrder, trades);
    }

    private void processAuctionOrderBook(Order newOrder, OrderBook orderBook, LinkedList<Trade> trades,
            int indicativeOpeningPrice) {
        while (orderBook.hasOrderOfType(newOrder.getSide().opposite()) && newOrder.getQuantity() > 0) {
            Order matchingOrder = orderBook.matchWithFirst(newOrder);
            if (matchingOrder == null)
                break;

            Trade trade = createAuctionTrade(newOrder, matchingOrder, indicativeOpeningPrice);
            trades.add(trade);

            updateOrderQuantities(newOrder, orderBook, matchingOrder);
        }
    }

    private Trade createAuctionTrade(Order newOrder, Order matchingOrder, int indicativeOpeningPrice) {
        Trade trade = new Trade(newOrder.getSecurity(), indicativeOpeningPrice,
                Math.min(newOrder.getQuantity(), matchingOrder.getQuantity()), newOrder, matchingOrder);
        trade.decreaseBuyersCredit();
        trade.increaseSellersCredit();
        adjustCredits(newOrder, matchingOrder, trade);
        return trade;
    }

    private void adjustCredits(Order newOrder, Order matchingOrder, Trade trade) {
        if (matchingOrder.getSide() == Side.BUY) {
            matchingOrder.getBroker().increaseCreditBy(trade.getQuantity() * matchingOrder.getPrice());
        } else {
            newOrder.getBroker().increaseCreditBy(trade.getQuantity() * newOrder.getPrice());
        }
    }

    private MatchResult finalizeAuctionMatch(Order newOrder, LinkedList<Trade> trades) {
        if (matchBasedOnMinimumExecutionQuantity(newOrder, trades)) {
            return MatchResult.executed(newOrder, trades);
        } else {
            return MatchResult.notEnoughQuantitiesMatched();
        }
    }

    private boolean matchBasedOnMinimumExecutionQuantity(Order newOrder, LinkedList<Trade> trades) {
        int sumOfTradeQuantities = calculateSumOfTradeQuantities(trades);
        if (newOrder.getMinimumExecutionQuantity() > sumOfTradeQuantities) {
            if (newOrder.getSide() == Side.SELL) {
                rollbackSellTrades(newOrder, trades);
            } else if (newOrder.getSide() == Side.BUY && !(newOrder instanceof StopLimitOrder)) {
                rollbackBuyTrades(newOrder, trades);
            }
            return false;
        } else
            return true;
    }

    private int calculateSumOfTradeQuantities(LinkedList<Trade> trades) {
        return trades.stream()
                .mapToInt(Trade::getQuantity)
                .sum();
    }

}
