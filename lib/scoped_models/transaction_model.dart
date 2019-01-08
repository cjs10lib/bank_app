import 'dart:async';

import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/services/deposit_service.dart';
import 'package:bank_app/services/withdrawal_service.dart';
import 'package:bank_app/services/funds_transfer_service.dart';
import 'package:bank_app/services/funds_loan_service.dart';

mixin FundsDepositModel implements GeneralModel {
  final _depositService = DepositService();

  Future<Map<String, dynamic>> createDeposit(
      double amount,
      String accountNumber,
      String transactionNumber,
      DateTime transactionDate) async {
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

mixin FundsWithdrawalModel implements GeneralModel {
  final _withdrawalService = WithdrawalService();

  Future<Map<String, dynamic>> createWithdrawal(
      double amount, String accountNumber) async {
    try {
      isLoading = true;
      notifyListeners();

      await _withdrawalService.createWithdrawal(
          authenticatedUser.uid, amount, accountNumber);

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

mixin FundsTransferModel implements GeneralModel {
  final _transferService = FundsTransferService();

  Future<Map<String, dynamic>> createTransfer(double amount,
      String accountNumber, String fromAccount, String toAccount) async {
    try {
      isLoading = true;
      notifyListeners();

      await _transferService.createTransfer(
          authenticatedUser.uid, amount, accountNumber, fromAccount, toAccount);

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

mixin FundsLoanModel implements GeneralModel {
  final _loanService = FundsLoanService();

  Future<Map<String, dynamic>> createLoan(double amount, String accountNumber,
      String fromAccount, String toAccount, DateTime payBackDate) async {
    try {
      isLoading = true;
      notifyListeners();

      await _loanService.createLoan(authenticatedUser.uid, amount,
          accountNumber, fromAccount, toAccount, payBackDate);

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
