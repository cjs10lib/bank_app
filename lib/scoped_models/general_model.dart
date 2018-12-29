import 'package:bank_app/models/wallet.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:bank_app/models/profile.dart';
import 'package:bank_app/models/user.dart';
import 'package:bank_app/services/auth_service.dart';
import 'package:bank_app/services/profile_service.dart';
import 'package:bank_app/services/wallet_service.dart';

mixin GeneralModel implements Model {
  bool isLoading = false;
  User authenticatedUser;
  Profile profile;
  String profileImageUrl;
  Wallet profileWallet;
  List<WalletTransaction> profileWalletTransactions;

  final authService = AuthService();
  final profileService = ProfileService();
  final walletService = WalletService();
}
