package domain;

import java.util.ArrayList;

public class TransactionEngine {
    ArrayList<Transaction> transactionHistory;
    int THRESHOLD = 1000;

    public TransactionEngine() {
        transactionHistory = new ArrayList<>();
    }

    int getAverageTransactionAmountByAccount(int accountId) {
        var totalAmount = 0;
        var count = 0;

        for (Transaction txn : transactionHistory) {
            if (txn.accountId == accountId) {
                totalAmount += txn.amount;
                count++;
            }
        }

        if (count == 0) {
            return 0;
        }

        return totalAmount / count;
    }

    int getTransactionPatternAboveThreshold(int threshold) {
        if (transactionHistory.isEmpty()) {
            return 0;
        }

        var diff = 0;
        var previous = transactionHistory.getFirst();

        for (Transaction txn : transactionHistory) {
            if (txn.transactionId == previous.transactionId) {
                continue;
            }

            if (txn.amount <= threshold) {
                continue;
            }

            if (diff == 0) {
                diff = txn.amount - previous.amount;
                previous = txn;
            } else if (diff != txn.amount - previous.amount) {
                return 0;
            }
        }

        return diff;
    }

    int detectFraudulentTransaction(Transaction txn) {
        var averageAmount = getAverageTransactionAmountByAccount(txn.accountId);

        if (txn.isDebit && txn.amount > 2 * averageAmount) {
            return txn.amount - 2 * averageAmount;  // Excessive debit, marked as suspicious
        }

        return 0;
    }

    public int addTransactionAndDetectFraud(Transaction txn) {
        if (transactionHistory.contains(txn)) {
            return 0;
        }

        var fraudScore = detectFraudulentTransaction(txn);
        if (fraudScore == 0) {
            fraudScore = getTransactionPatternAboveThreshold(THRESHOLD);
        }

        transactionHistory.add(txn);
        return fraudScore;
    }
}
