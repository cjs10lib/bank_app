import 'package:cloud_firestore/cloud_firestore.dart';

class FundsTransferService {
  final _db = Firestore.instance;
  final _serverTimestamp = FieldValue.serverTimestamp();

  Future<void> createTransfer(String uid, double amount, String accountNumber,
      String fromAccount, String toAccount) {
    return _db
        .collection('wallets')
        .document(uid)
        .collection('transactions')
        .document()
        .setData({
      'uid': uid,
      'transaction': 'DEBIT',
      'transactionType': 'TRANSFER',
      'amount': amount,
      'fromAccount': fromAccount,
      'toAccount': toAccount,
      'isProcessed': false,
      'processStatus': 'PENDING',
      'created': _serverTimestamp,
      'lastUpdate': _serverTimestamp
    });
  }
}
