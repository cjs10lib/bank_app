import 'package:bank_app/pages/sign_up_wizard_page.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';

import 'package:bank_app/pages/home_page.dart';
import 'package:bank_app/pages/auth_page.dart';
import 'package:bank_app/pages/tabs_page.dart';
import 'package:bank_app/pages/profile_page.dart';
import 'package:bank_app/pages/wallet_page.dart';
import 'package:bank_app/pages/loan_order_page.dart';
import 'package:scoped_model/scoped_model.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MainModel _model = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'Bank Application',
        theme: ThemeData(
            fontFamily: 'Quicksand',
            primaryColor: Color.fromRGBO(0, 17, 34, 1),
            accentColor: Color.fromRGBO(3, 48, 92, 1),
            errorColor: Colors.red),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => AuthPage(),
          // '/': (BuildContext context) => SignUpWizardPage(),
          '/tabs': (BuildContext context) => TabsPage(),
          '/home': (BuildContext context) => HomePage(),
          '/profile': (BuildContext context) => ProfilePage(),
          '/wallet': (BuildContext context) => WalletPage(),
          '/loan-order': (BuildContext context) => LoanOrderPage(),
          '/sign-up': (BuildContext context) => SignUpWizardPage(_model)
        },
      ),
    );
  }
}
