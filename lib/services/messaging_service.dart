
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessagingService {
  final _db = Firestore.instance;
   final _serverTimestamp = FieldValue.serverTimestamp();

  Future<void> createDeviceToken(String uid, String firstname, String lastname, String token) {
    return _db.collection('pushtokens').document(uid).setData({
      'firstname': firstname,
      'lastname': lastname,
      'token': token,
      'created': _serverTimestamp,
      'lastUpdate': _serverTimestamp
    });
  }
}