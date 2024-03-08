package com.example.demo;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
public class Receiver {

  private final ArrayList<Account> accounts = new ArrayList<>();
  @Autowired
  Sender sender;
  @JmsListener(destination = "INQ" )
  public void receiveMessage(String body ) {
    ArrayList<String> tokens = TokenizeMessage(body);
    String action = tokens.get(0);
    String AccNumber = tokens.get(1);
    Account account;

    switch (action) {
      case "DEPOSIT":
        account = getAccount(AccNumber , true);
        double amount = Double.parseDouble(tokens.get(2));
        account.deposit(amount);
        sender.send_message("0 Deposit successful");
        break;

      case "WITHDRAW":
        account = getAccount(AccNumber , false);
        amount = Double.parseDouble(tokens.get(2));
        int result = account.withdraw(amount);
        if (result == 1) {
          sender.send_message("1 Insufficient funds");
        }
        else {                                             
          sender.send_message("0 Withdraw successful");
        }
        break;

      case "BALANCE":
        account = getAccount(AccNumber , false);
        if(account != null){
          double balance = account.getBalance();
          sender.send_message(String.format("0 Balance: %.2f", balance));
        }
        break;

      default:
        System.out.println("Unknown action");
        break;
    }

  }

  private ArrayList<String> TokenizeMessage(String body) {
    ArrayList<String> tokens = new ArrayList<>();
    for (String token : body.split(" ")) {
      tokens.add(token);
    }
    return tokens;
  }

  private Account getAccount(String AccNumber , boolean makeNewAccount) {
    for (Account account : accounts) {
      if (account.getAccNumber().equals(AccNumber)) {
        return account;
      }
    }
    if (makeNewAccount == false) {
      sender.send_message("2 Unknown account number");
      return null;
    }
    else{
      Account newAccount = new Account(AccNumber);
      accounts.add(newAccount);
      return newAccount;
    }
  }

}