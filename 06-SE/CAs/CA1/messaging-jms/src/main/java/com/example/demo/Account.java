package com.example.demo;

public class Account {

    private final String AccNumber;
    private double Balance;
    
    public Account(String AccNumber) {
        this.AccNumber = AccNumber;
        this.Balance = 0;
    }
    
    public String getAccNumber() {
        return AccNumber;
    }
    
    public double getBalance() {
        return Balance;
    }

    public void setBalance(double Balance) {
        this.Balance = Balance;
    }

    public void deposit(double amount) {
        this.Balance += amount;
    }

    public int withdraw(double amount) {
        if (amount > this.Balance) {
            return 1; // Insufficient funds
        }
        this.Balance -= amount;
        return 0; // Success
    }
    
}
