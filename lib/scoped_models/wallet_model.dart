import 'package:bank_app/models/wallet.dart';
import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/services/wallet_service.dart';

mixin WalletModel implements GeneralModel {
  final walletService = WalletService();

  Wallet _wallet;

  Wallet get wallet => _wallet;

  Future<void> createWallet() async {
    try {
      isLoading = true;
      notifyListeners();

      await walletService.createWallet(
          authenticatedUser.uid, profile.mobilePhone);

      _wallet = Wallet(
        uid: authenticatedUser.uid,
        accountNumber: profile.mobilePhone,
        balance: 0.00
      );

      isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error.message);
      isLoading = false;
      notifyListeners();
    }
  }
}
