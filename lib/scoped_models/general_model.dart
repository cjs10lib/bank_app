
import 'package:scoped_model/scoped_model.dart';

import 'package:bank_app/models/user.dart';
import 'package:bank_app/services/auth_service.dart';

mixin GeneralModel implements Model {
  User authenticatedUser;
  bool isLoading = false;

  final authService = AuthService();
}