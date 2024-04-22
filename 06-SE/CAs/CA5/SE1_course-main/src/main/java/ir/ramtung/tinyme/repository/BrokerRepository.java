package ir.ramtung.tinyme.repository;

import ir.ramtung.tinyme.domain.entity.Broker;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Component
public class BrokerRepository {
    private final HashMap<Long, Broker> brokerById = new HashMap<>();
    public Broker findBrokerById(long brokerId) {
        return brokerById.get(brokerId);
    }
    public void addBroker(Broker broker) {
        brokerById.put(broker.getBrokerId(), broker);
    }

    public void clear() {
        brokerById.clear();
    }
    Iterable<? extends Broker> allBrokers() {
        return brokerById.values();
    }
}
