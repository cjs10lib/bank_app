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
        .document(transactionNumber)
        .setData({
      'transaction': 'CREDIT',
      'transactionType': 'DEPOSIT',
      'amount': amount,
      'fromAccount': accountNumber,
      'toAccount': accountNumber,
      'transactionDate': transactionDate,
      'isConfirmed': false,
      'isCredited': false,
      'created': _serverTimestamp,
      'lastUpdate': _serverTimestamp
    });
  }
}
