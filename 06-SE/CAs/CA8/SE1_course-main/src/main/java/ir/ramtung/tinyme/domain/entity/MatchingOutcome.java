package ir.ramtung.tinyme.domain.entity;

public enum MatchingOutcome {
    EXECUTED,
    NOT_ENOUGH_CREDIT,
    NOT_ENOUGH_POSITIONS,
    NOT_ENOUGH_QUANTITIES_MATCHED,
    INACTIVE_ORDER_ENQUEUED,
    ORDER_ENQUEUED_IN_AUCTION_MODE,
    TRADED
}
