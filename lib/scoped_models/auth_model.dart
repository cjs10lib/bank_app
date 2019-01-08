import 'dart:async';

import 'package:bank_app/models/auth.dart';
import 'package:bank_app/models/user.dart';
import 'package:bank_app/scoped_models/general_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

mixin AuthModel implements GeneralModel {
  User get authUser => authenticatedUser;

  Future<void> getAuthenticatedUser() async {
    try {
      FirebaseUser user = await authService.authenticatedUser();
      if (user != null) {
        authenticatedUser = User(uid: user.uid, email: user.email);
      }
      notifyListeners();

      print(user.uid);
    } catch (error) {
      print(error.message);
    }
  }

  Future<Map<String, dynamic>> authenticate(
      String email, String password, AuthMode authMode) async {
    FirebaseUser user;

    try {
      isLoading = true;
      notifyListeners();

      authMode == AuthMode.Login
          ? user = await authService.signInWithEmailAndPassword(email, password)
          : user =
              await authService.createUserWithEmailAndPassword(email, password);

      authenticatedUser = User(uid: user.uid, email: user.email);

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Authentication successfull'};
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': error.message};
    }
  }

  Future<void> signOut() async {
    await authService.signout();
    profileAccountStatus = null;
    profile = null;
    profileImageUrl = null;
    profileWallet = null;
    profileWalletTransactions = null;
    authenticatedUser = null;

    bankOffers = null;
    // notifyListeners();
  }
}
