import 'dart:async';

import 'package:bank_app/pages/funds_deposit_page.dart';
import 'package:bank_app/pages/funds_transfer_page.dart';
import 'package:bank_app/pages/funds_withdrawal_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:bank_app/pages/home_page.dart';
import 'package:bank_app/pages/auth_page.dart';
import 'package:bank_app/pages/tabs_page.dart';
import 'package:bank_app/pages/profile_page.dart';
import 'package:bank_app/pages/funds_loan_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bank_app/pages/sign_up_wizard_page.dart';
import 'package:bank_app/pages/pending_activation_page.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  FirebaseMessaging _messaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _messaging.configure(onMessage: (Map<String, dynamic> message) {
      print('OnMessage ${message.values}');
      showNotification(message);
    }, onLaunch: (Map<String, dynamic> message) {
      print('OnLaunch ${message.values}');
    }, onResume: (Map<String, dynamic> message) {
      print('OnResume ${message.values}');
    });

    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android, iOS);

    _localNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    _localNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    super.initState();
  }

  Future showNotification(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails(
        'channel_id', 'CHANNEL NAME', 'channelDescription',
        importance: Importance.Max, priority: Priority.High);
    var iOS = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(android, iOS);

    Map<String, dynamic> notification = {
      'title': message['notification']['title'],
      'body': message['notification']['body'],
    };

    print(
        'Show notifications Details ${notification['title']},,,, ${notification['body']}');

    await _localNotificationsPlugin.show(0, notification['title'],
        notification['body'], platformChannelSpecifics,
        payload: notification['body']);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('payload: $payload');
    }

    // Future.delayed(Duration.zero, () {
    //   showDialog(
    //       context: context,
    //       barrierDismissible: true,
    //       builder: (_) {
    //         return AlertDialog();
    //       });
    // });

    //       return Dialog(
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(20.0)),
    //         child: Container(
    //           height: 300.0,
    //           width: 200.0,
    //           decoration:
    //               BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
    //           child: Column(
    //             children: <Widget>[
    //               Container(
    //                 height: 100.0,
    //                 alignment: Alignment.center,
    //                 child: Text('KAMCCU CORP CREDIT UNION',
    //                     style: TextStyle(fontSize: 20.0)),
    //               ),
    //               SizedBox(height: 20),
    //               Container(
    //                 height: 100.0,
    //                 child: Text(payload, style: TextStyle(fontSize: 15.0)),
    //               ),
    //               SizedBox(height: 20),
    //               Row(
    //                 children: <Widget>[
    //                   RaisedButton(
    //                       child: Text('Okay'),
    //                       onPressed: () => Navigator.of(context).pop())
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       );
    //     });
  }

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
          '/tabs': (BuildContext context) => TabsPage(_model),
          '/home': (BuildContext context) => HomePage(),
          '/profile': (BuildContext context) => ProfilePage(),
          '/loan': (BuildContext context) => FundsLoanPage(_model),
          '/transfer': (BuildContext context) => FundsTransferPage(_model),
          '/deposit': (BuildContext context) => FundsDepositPage(_model),
          '/withdrawal': (BuildContext context) => FundsWithdrawalPage(_model),
          '/sign-up': (BuildContext context) => SignUpWizardPage(),
          '/pending-activation': (BuildContext context) =>
              PendingActivationPage()
        },
      ),
    );
  }
}
