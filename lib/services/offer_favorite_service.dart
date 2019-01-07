import 'package:cloud_firestore/cloud_firestore.dart';

class OfferFavoriteService {
  final _db = Firestore.instance.collection('offers');

  Future<bool> isFavorited(String offerId, String authenticatedUserId) async {
    var document = await _db
        .document(offerId)
        .collection('wish-list')
        .document(authenticatedUserId)
        .get();

    return document.exists;
  }

  Future<void> addToFavorite(String offerId, String authenticatedUserId) {
    return _db
        .document(offerId)
        .collection('wish-list')
        .document(authenticatedUserId)
        .setData({'isFavorite': true});
  }

  Future<void> removeFromFavorite(String offerId, String authenticatedUserId) {
    return _db
        .document(offerId)
        .collection('wish-list')
        .document(authenticatedUserId)
        .delete();
  }
}
