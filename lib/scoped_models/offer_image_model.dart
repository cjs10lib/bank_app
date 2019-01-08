import 'dart:async';
import 'dart:io';

import 'package:bank_app/scoped_models/general_model.dart';
import 'package:bank_app/services/offer_image_service.dart';

mixin OfferImageModel implements GeneralModel {
  final _offerImageService = OfferImageService();

  Future<Map<String, dynamic>> uploadOfferImage(File offerImage) async {
    try {
      isLoading = true;
      notifyListeners();

      String offerImageUrl =
          await _offerImageService.saveOfferImage(offerImage);

      isLoading = false;
      notifyListeners();

      print('Offer image url $offerImageUrl');
      return {'success': true, 'donwloadUrl': offerImageUrl};
    } catch (error) {
      isLoading = false;
      notifyListeners();

      print('Error ${error.message}');
      return {'success': false, 'donwloadUrl': error.message};
    }
  }
}
