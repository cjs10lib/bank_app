import 'package:flutter/material.dart';

class Wallet {
  String uid;
  String accountNumber;
  double balance;
  dynamic created;
  dynamic lastUpdate;

  Wallet({@required this.uid, @required this.accountNumber, @required this.balance, this.created, this.lastUpdate});
}