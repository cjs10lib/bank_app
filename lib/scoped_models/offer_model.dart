import 'dart:async';

import 'package:bank_app/models/offer.dart';
import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/services/offer_service.dart';
import 'package:bank_app/services/offer_favorite_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin OfferModel implements GeneralModel {
  final _offerService = OfferService();
  final _offerFavoriteService = OfferFavoriteService();
  // 0557432320
  // 0541161854
  // 0504992202

  String _selectedOfferId;
  bool _showFavorite = false;

  List<Offer> get offers {
    if (_showFavorite) {
      return bankOffers
          .where((Offer offer) => offer.isFavorite == true)
          .toList();
    }

    return List.from(bankOffers);
  }

  Offer get selectedOffer => offers.firstWhere((Offer offer) {
        return offer.id == _selectedOfferId;
      });

  bool get displayFavoritesOnly => _showFavorite;

  void selectOffer(String offerId) {
    _selectedOfferId = offerId;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorite = !_showFavorite;
    notifyListeners();
  }

  fetchOffers() async {
    isLoading = true;
    notifyListeners();

    try {
      return _offerService.fetchOffers().then((QuerySnapshot snapshot) {
        if (snapshot.documents.length < 1) {
          isLoading = false;
          notifyListeners();
          return;
        }

        List<Offer> _offers = [];
        snapshot.documents.forEach((DocumentSnapshot snap) async {
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
          notifyListeners();

          Offer offerData = _offers.firstWhere((Offer data) {
            return data.id == offer.id;
          });

          int index = _offers.indexWhere((Offer data) {
            return data.id == offer.id;
          });

          bool isFavorited = await _offerFavoriteService.isFavorited(
              offer.id, authenticatedUser.uid);

          offerData = Offer(
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
              isFavorite: isFavorited ? true : false);

          _offers[index] = offerData;
          notifyListeners();
        });

        bankOffers = _offers;
        notifyListeners();

        isLoading = false;
        notifyListeners();
      }).catchError((error) {
        print(error.message);
      });
      // .timeout(const Duration(seconds: 5), onTimeout: onTimeout);
    } catch (error) {
      print(error.message);
    }
  }

  void onTimeout() {
    print('Fetch timed out');
  }

  void toggleIsFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedOffer.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;

    final Offer updatedOfferStatus = Offer(
      id: selectedOffer.id,
      createdBy: selectedOffer.createdBy,
      title: selectedOffer.title,
      description: selectedOffer.description,
      amount: selectedOffer.amount,
      imageUrl: selectedOffer.imageUrl,
      startDate: selectedOffer.startDate,
      endDate: selectedOffer.endDate,
      created: selectedOffer.created,
      lastUpdate: selectedOffer.lastUpdate,
      isFavorite: newFavoriteStatus,
    );

    final int _offerIndex = bankOffers.indexWhere((Offer offer) {
      return offer.id == _selectedOfferId;
    });

    bankOffers[_offerIndex] = updatedOfferStatus;
    notifyListeners();

    try {
      if (newFavoriteStatus) {
        _offerFavoriteService.addToFavorite(
            _selectedOfferId, authenticatedUser.uid);
        print('added');
      } else {
        _offerFavoriteService.removeFromFavorite(
            _selectedOfferId, authenticatedUser.uid);
        print('removed');
      }

      _selectedOfferId = null;
    } catch (error) {
      print(error);
      final Offer updatedOfferStatus = Offer(
        id: selectedOffer.id,
        createdBy: selectedOffer.createdBy,
        title: selectedOffer.title,
        description: selectedOffer.description,
        amount: selectedOffer.amount,
        imageUrl: selectedOffer.imageUrl,
        startDate: selectedOffer.startDate,
        endDate: selectedOffer.endDate,
        created: selectedOffer.created,
        lastUpdate: selectedOffer.lastUpdate,
        isFavorite: !newFavoriteStatus,
      );

      _selectedOfferId = null;
      bankOffers[_offerIndex] = updatedOfferStatus;
      notifyListeners();
    }
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
