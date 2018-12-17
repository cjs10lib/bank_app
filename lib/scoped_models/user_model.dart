import 'dart:convert';

import 'package:bank_app/models/auth_mode.dart';
import 'package:bank_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:bank_app/services/auth_service.dart';

class UserModel extends Model {
  User _authenticatedUser;
  bool isLoading = false;

  final _authService = AuthService();

  Future<Map<String, dynamic>> authenticate(
      String email, String password, AuthMode authMode) async {
    FirebaseUser user;

    try {
      isLoading = true;
      notifyListeners();

      authMode == AuthMode.Login
          ? user =
              await _authService.signInWithEmailAndPassword(email, password)
          : user = await _authService.createUserWithEmailAndPassword(
              email, password);
              
      _authenticatedUser = User(uid: user.uid, email: user.email);

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
