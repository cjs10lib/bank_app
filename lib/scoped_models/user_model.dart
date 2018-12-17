import 'dart:convert';

import 'package:bank_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:bank_app/services/auth_service.dart';

class UserModel extends Model {
  User _authenticatedUser;

  final _authService = AuthService();

  Future<Map<String, dynamic>> authenticate(
      String email, String password) async {
    FirebaseUser user;

    try {
      user = await _authService.createUserWithEmailAndPassword(email, password);
      _authenticatedUser = User(uid: user.uid, email: user.email);

      return {'success': true, 'message': 'Authentication successfull'};
    } catch (error) {
      return {'success': false, 'message': error.message};
    }
  }
}
