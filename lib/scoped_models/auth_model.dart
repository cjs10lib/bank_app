import 'package:bank_app/models/auth.dart';
import 'package:bank_app/models/user.dart';
import 'package:bank_app/scoped_models/general_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

mixin AuthModel implements GeneralModel {
  Future<Null> getAuthenticatedUser() async {
    FirebaseUser user = await authService.authenticatedUser();
    authenticatedUser = User(uid: user.uid, email: user.email);
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

  // Future<Null> signOut() async {
  //   return await authService.signout();
  // }
}
