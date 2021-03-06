import 'package:scoped_model/scoped_model.dart';

import 'package:bank_app/scoped_models/general_model.dart';
import 'package:bank_app/scoped_models/auth_model.dart';
import 'package:bank_app/scoped_models/profile_model.dart';
import 'package:bank_app/scoped_models/profile_image_model.dart';
import 'package:bank_app/scoped_models/account_model.dart';
import 'package:bank_app/scoped_models/wallet_model.dart';
import 'package:bank_app/scoped_models/transaction_model.dart';
import 'package:bank_app/scoped_models/messaging_model.dart';
import 'package:bank_app/scoped_models/offer_model.dart';
import 'package:bank_app/scoped_models/offer_image_model.dart';

class MainModel extends Model
    with
        GeneralModel,
        AuthModel,
        ProfileModel,
        ProfileImageModel,
        AccountModel,
        WalletModel,
        FundsDepositModel,
        FundsWithdrawalModel,
        FundsTransferModel,
        FundsLoanModel,
        MessagingModel,
        OfferModel,
        OfferImageModel {}
