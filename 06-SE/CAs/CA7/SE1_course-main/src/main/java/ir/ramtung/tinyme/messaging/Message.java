package ir.ramtung.tinyme.messaging;

public class Message {
    public static final String INVALID_ORDER_ID = "Invalid order ID";
    public static final String ORDER_QUANTITY_NOT_POSITIVE = "Order quantity is not-positive";
    public static final String ORDER_PRICE_NOT_POSITIVE = "Order price is not-positive";
    public static final String UNKNOWN_SECURITY_ISIN = "Unknown security ISIN";
    public static final String ORDER_ID_NOT_FOUND = "Order ID not found in the order book";
    public static final String INVALID_PEAK_SIZE = "Iceberg order peak size is out of range";
    public static final String CANNOT_SPECIFY_PEAK_SIZE_FOR_A_NON_ICEBERG_ORDER = "Cannot specify peak size for a non-iceberg order";
    public static final String UNKNOWN_BROKER_ID = "Unknown broker ID";
    public static final String UNKNOWN_SHAREHOLDER_ID = "Unknown shareholder ID";
    public static final String BUYER_HAS_NOT_ENOUGH_CREDIT = "Buyer has not enough credit";
    public static final String QUANTITY_NOT_MULTIPLE_OF_LOT_SIZE = "Quantity is not a multiple of security lot size";
    public static final String PRICE_NOT_MULTIPLE_OF_TICK_SIZE = "Price is not a multiple of security tick size";
    public static final String SELLER_HAS_NOT_ENOUGH_POSITIONS = "Seller has not enough positions";
    public static final String MINIMUM_EXECUTION_QUANTITY_IS_NEGATIVE = "Minimum execution quantity is negative" ;
    public static final String MINIMUM_EXECUTION_QUANTITY_IS_MORE_THAN_QUANTITY = "Minimum execution quantity is more than quantity";
    public static final String CAN_NOT_UPDATE_ORDER_MINIMUM_EXECUTION_QUANTITY = "Can not update order minimum execution quantity";
    public static final String STOP_LIMIT_ORDER_CANT_BE_ICEBERG = "stop limit order can not be an iceberg order";
    public static final String STOP_LIMIT_ORDER_CANT_MEQ = "stop limit order can not have MEQ";
    public static final String UPDATING_REJECTED_BECAUSE_IT_IS_NOT_STOP_LIMIT_ORDER = "updating rejected because it is not a stop limit order(it does not have stop price)";
    public static final String UPDATING_REJECTED_BECAUSE_THE_STOP_LIMIT_ORDER_IS_ACTIVE ="updating rejected because the stop limit order is active";
    public static final String MINIMUM_EXECUTION_QUANTITY_IS_MORE_THAN_ALL_QUANTITIES = "MEQ is more than sum of quantities"; 
    public static final String MEQ_IS_PROHIBITED_IN_AUCTION_MODE = "having meq for orders is prohibited in auction mode"  ;   
    public static final String STOPLIMIT_ORDER_IN_AUCTION_MODE_ERROR = "new stopLimit order is prohibited in auction mode" ;
    public static final String STOPLIMIT_ORDER_IN_AUCTION_MODE_CANT_REMOVE = "stopLimit order in auction mode can not be deleted";
    public static final String STOPLIMIT_ORDER_IN_AUCTION_MODE_CANT_UPDATE = "stopLimit order in auction mode can not be updated";
          
}
