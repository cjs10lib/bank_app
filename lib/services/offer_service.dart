import 'package:cloud_firestore/cloud_firestore.dart';

class OfferService {
  final _db = Firestore.instance;
  final _serverDate = FieldValueType.serverTimestamp;

  Future<DocumentReference> createOffer(String uid, String title,
      String description, double amount, DateTime startDate, DateTime endDate) {
    return _db.collection('offers').add({
      'createdBy': uid,
      'title': title,
      'description': description,
      'amount': amount,
      'startDate': startDate,
      'enddate': endDate,
      'created': _serverDate,
      'lastupdate': _serverDate
    });
  }
}
