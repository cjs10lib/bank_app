import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final _db = Firestore.instance;
  final _serverTimestamp = FieldValue.serverTimestamp();

  Future<DocumentSnapshot> fetchProfile(String uid) {
    return _db.collection('people').document(uid).get();
  }

  Future<void> createProfile(String uid, String firstname, String lastname,
      String mobilePhone, String otherPhone, String address) {
    return _db.collection('people').document(uid).setData({
      'firstname': firstname,
      'lastname': lastname,
      'mobilePhone': mobilePhone,
      'otherPhone': otherPhone,
      'address': address,
      'created': _serverTimestamp,
      'lastUpdate': _serverTimestamp
    }, merge: true);
  }
}
