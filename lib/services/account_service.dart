import 'package:cloud_firestore/cloud_firestore.dart';

class AccountService {
  final _db = Firestore.instance;
  final serverTimestamp = FieldValue.serverTimestamp();

  Future<void> createAccount(String uid) {
    return _db.collection('account').document(uid).setData({
      'uid': uid,
      'acceptTerms': true,
      'isActivated': false,
      'created': serverTimestamp,
      'lastUpdate': serverTimestamp
    }, merge: true);
  }
}
