import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final _db = Firestore.instance;
  final serverTimestamp = FieldValue.serverTimestamp();

  Future<void> createProfile(String uid, String firstname, String lastname,
      String mobilePhone, String otherPhone) {
    return _db.collection('accounts').document(uid).setData({
      'firstname': firstname,
      'lastname': lastname,
      'mobilePhone': mobilePhone,
      'otherPhone': otherPhone,
      'created': serverTimestamp,
      'lastUpdate': serverTimestamp
    }, merge: true);
  }
}
