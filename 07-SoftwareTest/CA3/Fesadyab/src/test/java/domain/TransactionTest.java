package domain;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class TransactionTest {

    @Test
    @DisplayName("Test equality when transactions have the same IDs")
    public void should_ReturnEqual_When_TransactionIdsAreSame() {
        Transaction txn1 = new Transaction();
        txn1.setTransactionId(1);
        txn1.setAccountId(100);
        txn1.setAmount(500);

        Transaction txn2 = new Transaction();
        txn2.setTransactionId(1);
        txn2.setAccountId(200);
        txn2.setAmount(1000);

        assertEquals(txn1, txn2);
    }

    @Test
    @DisplayName("Test inequality when transactions have different IDs")
    public void should_ReturnNotEqual_When_TransactionIdsAreDifferent() {
        Transaction txn1 = new Transaction();
        txn1.setTransactionId(1);
        txn1.setAccountId(100);
        txn1.setAmount(500);

        Transaction txn2 = new Transaction();
        txn2.setTransactionId(2);
        txn2.setAccountId(100);
        txn2.setAmount(500);

        assertNotEquals(txn1, txn2);
    }

    @Test
    @DisplayName("Test inequality when transaction is compared to null")
    public void should_ReturnNotEqual_When_ComparedWithNull() {
        Transaction txn = new Transaction();
        txn.setTransactionId(1);
        txn.setAccountId(100);
        txn.setAmount(500);

        assertNotEquals(txn, null);
    }

    @Test
    @DisplayName("Test equality when transaction is compared to itself")
    public void should_ReturnEqual_When_ComparedWithItself() {
        Transaction txn = new Transaction();
        txn.setTransactionId(1);
        txn.setAccountId(100);
        txn.setAmount(500);

        assertEquals(txn, txn);
    }

}
