import 'package:flutter/material.dart';

class Wallet {
  String uid;
  String accountNumber;
  double balance;
  dynamic created;
  dynamic lastUpdate;

  Wallet(
      {@required this.uid,
      @required this.accountNumber,
      @required this.balance,
      this.created,
      this.lastUpdate});
}

class WalletTransaction {
  String uid;
  String transaction;
  String transactionType;
  double amount;
  bool isProcessed;
  String processStatus;
  dynamic created;
  dynamic lastUpdate;

  WalletTransaction(
      {@required this.uid,
      @required this.transaction,
      @required this.transactionType,
      @required this.amount,
      @required this.isProcessed,
      @required this.processStatus,
      this.created,
      this.lastUpdate});
}
