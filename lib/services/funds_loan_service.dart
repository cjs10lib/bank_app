import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FundsLoanService {
  final _db = Firestore.instance;
  final _serverTimestamp = FieldValue.serverTimestamp();

  Future<void> createLoan(String uid, double amount, String accountNumber,
      String fromAccount, String toAccount, DateTime payBackDate) {
    return _db
        .collection('wallets')
        .document(uid)
        .collection('transactions')
        .document()
        .setData({
      'uid': uid,
      'transaction': 'CREDIT',
      'transactionType': 'LOAN',
      'amount': amount,
      'fromAccount': fromAccount,
      'toAccount': toAccount,
      'isProcessed': false,
      'processStatus': 'PENDING',
      'payBackDate': payBackDate,
      'created': _serverTimestamp,
      'lastUpdate': _serverTimestamp
    });
  }
}
