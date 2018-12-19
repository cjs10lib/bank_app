import 'package:bank_app/models/profile.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PendingActivationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      Profile _profile = model.profile;

      return Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/login/login-background.jpg'))),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Not Activated!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 50.0),
                Text(
                    'Sorry ${_profile.firstname}! Your account is still pending activation. We will inform you when your account is activated.',
                    style: TextStyle(color: Colors.white, fontSize: 16.0)),
                SizedBox(height: 50.0),
                GestureDetector(
                  onTap: () {
                    model.signOut().then((_) {
                      Navigator.of(context).pushReplacementNamed('/');
                    });
                  },
                  child: Container(
                    height: 40.0,
                    width: 160.0,
                    color: Color.fromRGBO(59, 70, 80, 1),
                    alignment: Alignment.center,
                    child: Text('Okay',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }));
  }
}
