import 'package:bank_app/models/offer.dart';
import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/services/offer_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin OfferModel implements GeneralModel {
  final _offerService = OfferService();
  
  String _selectedOfferId;

  List<Offer> get offers => List.from(bankOffers);

  Offer get selectedOffer => bankOffers.firstWhere((Offer offer) {
        return offer.id == _selectedOfferId;
      });

  void selectOffer(String offerId) {
    _selectedOfferId = offerId;
    notifyListeners();
  }

  fetchOffers() async {
    isLoading = true;
    notifyListeners();

    return _offerService.fetchOffers().then((QuerySnapshot snapshot) {
      if (snapshot.documents.length < 1) {
        isLoading = false;
        notifyListeners();
        return;
      }
      print('offersssss ${snapshot.documents.length}');
      List<Offer> _offers = [];
      snapshot.documents.forEach((DocumentSnapshot snap) {
        final offer = Offer(
          id: snap.documentID,
          createdBy: snap.data['createdBy'],
          title: snap.data['title'],
          description: snap.data['description'],
          amount: snap.data['amount'],
          imageUrl: snap.data['offerImageUrl'],
          startDate: snap.data['startDate'],
          endDate: snap.data['endDate'],
          created: snap.data['created'],
          lastUpdate: snap.data['lastUpdate'],
        );

        _offers.add(offer);

        print('Offer data ${snap.data.values}');
      });

      bankOffers = _offers;
      notifyListeners();

      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      print(error.message);
    });
  }

  Future<Map<String, dynamic>> createOffer(
      String title,
      String description,
      double amount,
      DateTime startDate,
      DateTime endDate,
      String offerImageUrl) async {
    try {
      isLoading = true;
      notifyListeners();

      final doc = await _offerService.createOffer(authenticatedUser.uid, title,
          description, amount, startDate, endDate, offerImageUrl);

      isLoading = false;
      notifyListeners();

      print(doc.documentID);
      return {'success': true, 'message': doc.documentID};
    } catch (error) {
      isLoading = false;
      notifyListeners();
      print('Upload Completed and unsuccessful ${error.message}');
      return {'success': false, 'message': error.message};
    }
  }
}
