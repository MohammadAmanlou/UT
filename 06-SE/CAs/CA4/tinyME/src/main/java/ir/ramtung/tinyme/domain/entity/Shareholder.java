package ir.ramtung.tinyme.domain.entity;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

import java.util.HashMap;
import java.util.Map;

@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Builder
public class Shareholder {
    @Getter
    @EqualsAndHashCode.Include
    private long shareholderId;
    @Getter
    private String name;
    @Getter
    @Builder.Default
    private Map<Security, Integer> positions = new HashMap<>();

    public void incPosition(Security security, int amount) {
        assert amount >= 0;
        positions.put(security, positions.getOrDefault(security, 0) + amount);
    }

    public void decPosition(Security security, int amount) {
        assert amount >= 0;
        int currentPositions = positions.getOrDefault(security, 0);
        if (currentPositions < amount)
            throw new IllegalArgumentException("Amount to be decreased is greater than shareholder's current position");
        positions.put(security, currentPositions - amount);
    }
    public boolean hasEnoughPositionsOn(Security security, int position) {
        return positions.getOrDefault(security, 0) >= position;
    }
}
