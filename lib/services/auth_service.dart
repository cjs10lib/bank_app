import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<FirebaseUser> createUserWithEmailAndPassword(String email, String password) {
    return auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}