import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DepositService {
  final _db = Firestore.instance;
  final _serverTimestamp = FieldValue.serverTimestamp();

  Future<void> createDeposit(String uid, double amount, String accountNumber,
      String transactionNumber, DateTime transactionDate) {
    return _db
        .collection('wallets')
        .document(uid)
        .collection('transactions')
        .document()
        .setData({
      'uid': uid,
      'transaction': 'CREDIT',
      'transactionType': 'DEPOSIT',
      'amount': amount,
      'fromAccount': accountNumber,
      'toAccount': accountNumber,
      'transactionDate': transactionDate,
      'transactionNumber': transactionNumber,
      'isConfirmed': false,
      'isProcessed': false,
      'processStatus': 'PENDING',
      'created': _serverTimestamp,
      'lastUpdate': _serverTimestamp
    });
  }
}
