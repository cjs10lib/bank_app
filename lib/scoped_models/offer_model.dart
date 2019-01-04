import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/services/offer_service.dart';

mixin OfferModel implements GeneralModel {
  final _offerService = OfferService();

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
