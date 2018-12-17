
import 'package:scoped_model/scoped_model.dart';

import 'package:bank_app/scoped_models/general_model.dart';
import 'package:bank_app/scoped_models/account_model.dart';
import 'package:bank_app/scoped_models/user_model.dart';

class MainModel extends Model with GeneralModel, AccountModel, UserModel {}