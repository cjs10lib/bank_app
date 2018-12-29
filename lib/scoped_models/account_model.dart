import 'package:bank_app/models/account.dart';
import 'package:bank_app/scoped_models/general_model.dart';
import 'package:bank_app/services/account_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin AccountModel implements GeneralModel {
  Account _accountStatus;

  final _accountService = AccountService();

  Account get accountStatus => _accountStatus;

  Future<void> fetchAccount() async {
    try {
      DocumentSnapshot doc =
          await _accountService.fetchAccount(authenticatedUser.uid);
      final account = doc.data;

      if (doc.exists) {
        _accountStatus = Account(
            uid: authenticatedUser.uid,
            isActivated: account['isActivated'],
            created: account['created'],
            lastUpdate: account['lastUpdate']);

        notifyListeners();
        print(account);
      }
    } catch (error) {
      print(error.message);
    }
  }

  Future<Map<String, dynamic>> createAccount() async {
    try {
      isLoading = true;
      notifyListeners();

      await _accountService.createAccount(authenticatedUser.uid);
      _accountStatus = Account(uid: authenticatedUser.uid, isActivated: false);

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Account created successfully'};
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': error.message};
    }
  }
}
