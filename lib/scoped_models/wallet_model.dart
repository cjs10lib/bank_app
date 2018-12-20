import 'package:bank_app/models/wallet.dart';
import 'package:bank_app/scoped_models/general_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin WalletModel implements GeneralModel {
  Wallet get wallet => profileWallet;

  fetchWallet() async {
    try {
      isLoading = true;
      notifyListeners();

      DocumentSnapshot snap =
          await walletService.fetchWallet(authenticatedUser.uid);
      profileWallet = Wallet(
          uid: authenticatedUser.uid,
          accountNumber: profile.mobilePhone,
          balance: snap.data['balance'],
          created: snap.data['created'],
          lastUpdate: snap.data['lastUpdate']);
      // notifyListeners();

      isLoading = false;
      notifyListeners();

      print(snap.data);
    } catch (error) {
      print(error);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createWallet() async {
    try {
      isLoading = true;
      notifyListeners();

      await walletService.createWallet(
          authenticatedUser.uid, profile.mobilePhone);

      profileWallet = Wallet(
          uid: authenticatedUser.uid,
          accountNumber: profile.mobilePhone,
          balance: 0.00);

      isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error.message);
      isLoading = false;
      notifyListeners();
    }
  }
}
