import 'package:cloud_firestore/cloud_firestore.dart';

class OfferService {
  final _db = Firestore.instance;
  final _serverTimestamp = FieldValue.serverTimestamp();

  Future<DocumentReference> createOffer(String uid, String title,
      String description, double amount, DateTime startDate, DateTime endDate) {
    return _db.collection('offers').add({
      'createdBy': uid,
      'title': title,
      'description': description,
      'amount': amount,
      'startDate': startDate,
      'enddate': endDate,
      'created': _serverTimestamp,
      'lastupdate': _serverTimestamp
    });
  }
}