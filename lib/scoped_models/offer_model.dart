import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/services/offer_service.dart';

mixin OfferModel implements GeneralModel {
  final _offerService = OfferService();

  createOffer(String title, String description, double amount,
      DateTime startDate, DateTime endDate) async {
    final doc = await _offerService.createOffer(
        authenticatedUser.uid, title, description, amount, startDate, endDate);

    print(doc.documentID);
  }
}
