import 'package:bank_app/models/wallet.dart';
import 'package:bank_app/scoped_models/general_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin WalletModel implements GeneralModel {
  Wallet get wallet => profileWallet;

  List<WalletTransaction> get walletTransactions =>
      List.from(profileWalletTransactions);

  fetchWallet() async {
    isLoading = true;
    notifyListeners();

    return walletService
        .fetchWallet(authenticatedUser.uid)
        .then((DocumentSnapshot snap) {
      profileWallet = Wallet(
          uid: authenticatedUser.uid,
          accountNumber: profile.mobilePhone,
          balance: snap.data['balance'],
          created: snap.data['created'],
          lastUpdate: snap.data['lastUpdate']);
      notifyListeners();

      isLoading = false;
      notifyListeners();

      print(snap.data);
    });
  }

  fetchWalletTransactions(
      {int transactionMonth,
      int transactionYear,
      bool filterByMonthYear = false}) {
    isLoading = true;
    notifyListeners();

    return walletService
        .fetchWalletTransactions(authenticatedUser.uid)
        .then((QuerySnapshot snap) {
      if (snap.documents.length == -1) {
        isLoading = false;
        notifyListeners();
        return;
      }
      final List<WalletTransaction> transactions = [];

      snap.documents.forEach((DocumentSnapshot document) {
        transactions.add(WalletTransaction(
          uid: document.documentID,
          transaction: document.data['transaction'],
          transactionType: document.data['transactionType'],
          amount: document.data['amount'],
          isProcessed: document.data['isProcessed'],
          processStatus: document.data['processStatus'],
          created: document.data['created'],
          lastUpdate: document.data['lastUpdate'],
        ));
      });

      profileWalletTransactions = filterByMonthYear
          ? transactions.where((WalletTransaction transaction) {
              return transaction.lastUpdate.year == transactionYear &&
                  transaction.lastUpdate.month == transactionMonth;
            }).toList()
          : profileWalletTransactions = transactions;

      notifyListeners();
      isLoading = false;
      notifyListeners();

      print(snap.documents.map((docs) => docs.data));
    }).catchError((error) {
      print(error.message);
    });
  }

  Future<void> createWallet() async {
    try {
      isLoading = true;
      notifyListeners();

      await walletService.createWallet(
          authenticatedUser.uid, profile.mobilePhone);

      profileWallet = Wallet(
          uid: authenticatedUser.uid,
          accountNumber: profile.mobilePhone,
          balance: 0.00);

      isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error.message);
      isLoading = false;
      notifyListeners();
    }
  }
}
