import 'package:bank_app/models/auth_mode.dart';
import 'package:bank_app/models/user.dart';
import 'package:bank_app/scoped_models/general_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

mixin AccountModel implements GeneralModel {    

  Future<Map<String, dynamic>> authenticate(
      String email, String password, AuthMode authMode) async {
    FirebaseUser user;

    try {
      isLoading = true;
      notifyListeners();

      authMode == AuthMode.Login
          ? user =
              await authService.signInWithEmailAndPassword(email, password)
          : user = await authService.createUserWithEmailAndPassword(
              email, password);
              
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
}
