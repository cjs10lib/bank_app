import 'package:bank_app/scoped_models/general_model.dart';
import 'package:bank_app/services/deposit_service.dart';

mixin FundsDepositModel implements GeneralModel {
  final _depositService = DepositService();

  Future<Map<String, dynamic>> createDeposit(double amount, String accountNumber,
      String transactionNumber, DateTime transactionDate) async {
    try {
      isLoading = true;
      notifyListeners();

      await _depositService.createDeposit(authenticatedUser.uid, amount,
          accountNumber, transactionNumber, transactionDate);

      isLoading = false;
      notifyListeners();

      return {'success': true, 'message': 'Transaction Successful'};
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': error.message};
    }
  }
}
