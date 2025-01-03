package domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Transaction {
    int transactionId;
    int accountId;
    int amount;
    boolean isDebit;

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Transaction transaction) {
            return transactionId == transaction.transactionId;
        }
        return false;
    }
}
