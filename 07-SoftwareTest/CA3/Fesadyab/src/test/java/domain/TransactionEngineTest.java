package domain;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class TransactionEngineTest {

    private TransactionEngine engine;

    @BeforeEach
    public void setup() {
        engine = new TransactionEngine();
    }

    private void addTransaction(Transaction transaction) {
        engine.transactionHistory.add(transaction);
    }

    @Test
    @DisplayName("Test getAverageTransactionAmountByAccount returns 0 when there are no transactions")
    public void should_ReturnZero_When_NoTransactionsForAccount() {
        int result = engine.getAverageTransactionAmountByAccount(1);
        assertEquals(0, result);
    }

    @Test
    @DisplayName("Test getAverageTransactionAmountByAccount returns correct average when transactions match account")
    public void should_ReturnAverageAmount_When_TransactionsMatchAccount() {
        Transaction txn1 = new Transaction();
        txn1.setAccountId(1);
        txn1.setAmount(100);

        Transaction txn2 = new Transaction();
        txn2.setAccountId(1);
        txn2.setAmount(300);

        addTransaction(txn1);
        addTransaction(txn2);

        int result = engine.getAverageTransactionAmountByAccount(1);
        assertEquals(200, result);
    }

    @Test
    @DisplayName("Test getAverageTransactionAmountByAccount returns 0 when there are no matching transactions")
    public void should_ReturnZero_When_NoTransactionsMatchAccount() {
        Transaction txn = new Transaction();
        txn.setAccountId(2);
        txn.setAmount(300);

        addTransaction(txn);

        int result = engine.getAverageTransactionAmountByAccount(1);
        assertEquals(0, result);
    }

    @Test
    @DisplayName("Test getTransactionPatternAboveThreshold returns 0 when there are no transactions")
    public void should_ReturnZeroPattern_When_NoTransactions() {
        int result = engine.getTransactionPatternAboveThreshold(1000);
        assertEquals(0, result);
    }

    @Test
    @DisplayName("Test getTransactionPatternAboveThreshold returns pattern value when consistent pattern is detected")
    public void should_ReturnPatternValue_When_ConsistentPatternDetected() {
        Transaction txn1 = new Transaction();
        txn1.setTransactionId(1);
        txn1.setAmount(1200);

        Transaction txn2 = new Transaction();
        txn2.setTransactionId(2);
        txn2.setAmount(1500);

        Transaction txn3 = new Transaction();
        txn3.setTransactionId(3);
        txn3.setAmount(1800);

        addTransaction(txn1);
        addTransaction(txn2);
        addTransaction(txn3);

        int result = engine.getTransactionPatternAboveThreshold(1000);
        assertEquals(300, result);
    }

    @Test
    @DisplayName("Test getTransactionPatternAboveThreshold returns 0 when pattern is inconsistent")
    public void should_ReturnZero_When_InconsistentPatternDetected() {
        Transaction txn1 = new Transaction();
        txn1.setTransactionId(1);
        txn1.setAmount(1200);

        Transaction txn2 = new Transaction();
        txn2.setTransactionId(2);
        txn2.setAmount(1500);

        Transaction txn3 = new Transaction();
        txn3.setTransactionId(3);
        txn3.setAmount(1700);

        addTransaction(txn1);
        addTransaction(txn2);
        addTransaction(txn3);

        int result = engine.getTransactionPatternAboveThreshold(1000);
        assertEquals(0, result);
    }

    @Test
    @DisplayName("Test detectFraudulentTransaction returns fraud score when fraudulent transaction is detected")
    public void should_ReturnFraudScore_When_FraudulentTransactionDetected() {
        Transaction txn1 = new Transaction();
        txn1.setAccountId(1);
        txn1.setAmount(500);

        addTransaction(txn1);

        Transaction txn2 = new Transaction();
        txn2.setAccountId(1);
        txn2.setAmount(1500);
        txn2.setDebit(true);

        int fraudScore = engine.detectFraudulentTransaction(txn2);
        assertEquals(500, fraudScore);
    }

    @Test
    @DisplayName("Test detectFraudulentTransaction returns 0 when no fraud is detected")
    public void should_ReturnZero_When_NoFraudulentTransactionDetected() {
        Transaction txn1 = new Transaction();
        txn1.setAccountId(1);
        txn1.setAmount(500);

        addTransaction(txn1);

        Transaction txn2 = new Transaction();
        txn2.setAccountId(1);
        txn2.setAmount(800);
        txn2.setDebit(true);

        int fraudScore = engine.detectFraudulentTransaction(txn2);
        assertEquals(0, fraudScore);
    }

    @Test
    @DisplayName("Test addTransactionAndDetectFraud returns 0 fraud score when transaction already exists")
    public void should_ReturnZeroFraudScore_When_TransactionAlreadyExists() {
        Transaction txn = new Transaction();
        txn.setTransactionId(1);
        txn.setAccountId(1);
        txn.setAmount(800);

        addTransaction(txn);

        int fraudScore = engine.addTransactionAndDetectFraud(txn);
        assertEquals(0, fraudScore);
    }

    @Test
    @DisplayName("Test addTransactionAndDetectFraud returns fraud score when fraud is detected")
    public void should_ReturnFraudScore_When_FraudDetectedOnAddTransaction() {
        Transaction txn1 = new Transaction();
        txn1.setTransactionId(1);
        txn1.setAccountId(1);
        txn1.setAmount(500);
        addTransaction(txn1);

        Transaction txn2 = new Transaction();
        txn2.setTransactionId(2);
        txn2.setAccountId(1);
        txn2.setAmount(1500);
        txn2.setDebit(true);

        int fraudScore = engine.addTransactionAndDetectFraud(txn2);
        assertEquals(500, fraudScore);
    }

    @Test
    @DisplayName("Test addTransactionAndDetectFraud returns 0 when no fraud is detected")
    public void should_ReturnZero_When_NoFraudDetectedOnAddTransaction() {
        Transaction txn = new Transaction();
        txn.setTransactionId(1);
        txn.setAccountId(1);
        txn.setAmount(800);

        int fraudScore = engine.addTransactionAndDetectFraud(txn);
        assertEquals(0, fraudScore);
    }

    @Test
    @DisplayName("Test getTransactionPatternAboveThreshold returns 0 when single transaction is below threshold")
    public void should_ReturnZero_When_SingleTransactionBelowThreshold() {
        Transaction txn1 = new Transaction();
        txn1.setTransactionId(1);
        txn1.setAmount(800);

        Transaction txn2 = new Transaction();
        txn2.setTransactionId(2);
        txn2.setAmount(900);

        addTransaction(txn1);
        addTransaction(txn2);

        int result = engine.getTransactionPatternAboveThreshold(1000);
        assertEquals(0, result);
    }

}
