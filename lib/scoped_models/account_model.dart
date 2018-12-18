import 'package:bank_app/models/account.dart';
import 'package:bank_app/scoped_models/general_model.dart';
import 'package:bank_app/services/account_service.dart';

mixin AccountModel implements GeneralModel {
  Account _accountStatus;

  final _accountService = AccountService();

  Future<Map<String, dynamic>> createAccount() async {
    try {
      await _accountService.createAccount(authenticatedUser.uid);
      _accountStatus = Account(uid: authenticatedUser.uid, isActivated: false);
      
      return {'success': true, 'message': 'Account created successfully'};
    } catch (error) {
      return {'success': false, 'message': error.message};
    }
  }
}
