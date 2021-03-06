import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class WalletService {
  final _db = Firestore.instance;
  final _serverTimestamp = FieldValue.serverTimestamp();

  Future<DocumentSnapshot> fetchWallet(String uid) {
    return _db.collection('wallets').document(uid).get();
  }

  Future<QuerySnapshot> fetchWalletTransactions(String uid) {
    return _db.collection('wallets').document(uid).collection('transactions').getDocuments();
  }

  Future<void> createWallet(String uid, String mobilePhone) {
    return _db.collection('wallets').document(uid).setData({
      'balance': 0.00,
      'account_number': mobilePhone,
      'created': _serverTimestamp,
      'lastUpdate': _serverTimestamp
    }, merge: true);
  }
}