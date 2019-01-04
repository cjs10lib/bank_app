import 'package:bank_app/models/offer.dart';
import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/services/offer_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin OfferModel implements GeneralModel {
  final _offerService = OfferService();

  List<Offer> _bankOffers;

  List<Offer> get offers => List.from(_bankOffers);

  fetchOffers() async {
    try {
      QuerySnapshot snapshot = await _offerService.fetchOffers();
      if (snapshot.documents.length < 1) {
        return;
      }
      List<Offer> _offers = [];
      snapshot.documents.forEach((DocumentSnapshot snap) {
        final offer = Offer(
          id: snap.documentID,
          createdBy: snap.data['createdBy'],
          title: snap.data['title'],
          description: snap.data['description'],
          amount: snap.data['amount'],
          startDate: snap.data['startDate'],
          endDate: snap.data['endDate'],
          created: snap.data['created'],
          lastUpdate: snap.data['lastUpdate'],
        );

        _offers.add(offer);

        print(snap.data.values);
      });

      _bankOffers = _offers;
      
    } catch (error) {
      print(error);
    }
  }

  Future<void> createOffer(String title, String description, double amount,
      DateTime startDate, DateTime endDate) async {
    try {
      isLoading = true;
      notifyListeners();

      final doc = await _offerService.createOffer(authenticatedUser.uid, title,
          description, amount, startDate, endDate);

      isLoading = false;
      notifyListeners();

      print(doc.documentID);
    } catch (error) {
      print(error);
      isLoading = false;
      notifyListeners();
    }
  }
}
