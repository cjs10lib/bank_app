import 'package:cloud_firestore/cloud_firestore.dart';

class WithdrawalService {
  final _db = Firestore.instance;
  final _serverTimestamp = FieldValue.serverTimestamp();

  Future<void> createWithdrawal(
      String uid, double amount, String accountNumber) {
    return _db
        .collection('wallets')
        .document(uid)
        .collection('transactions')
        .document()
        .setData({
      'uid': uid,
      'transaction': 'DEBIT',
      'transactionType': 'WITHDRAW',
      'amount': amount,
      'fromAccount': accountNumber,
      'toAccount': accountNumber,
      'transactionDate': _serverTimestamp,
      'isConfirmed': false,
      'isPerformed': false,
      'created': _serverTimestamp,
      'lastUpdate': _serverTimestamp
    });
  }
}
