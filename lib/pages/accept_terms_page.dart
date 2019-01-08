import 'dart:async';

import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AcceptTermsPage extends StatelessWidget {
  final Function _navigateBackwards;

  AcceptTermsPage(this._navigateBackwards);

  Widget _buildMessage(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _targetWidth = _deviceWidth > 550.0 ? 500.0 : _deviceWidth * .90;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: _targetWidth,
      child: Text(
          'Thank you for signing up. We will review your credentials and notify you on approval.',
          style: TextStyle(fontSize: 20.0, color: Colors.white)),
    );
  }

  Widget _buildControls(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _navigateBackwards();
            },
            child: Container(
              height: 40.0,
              width: 80.0,
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: Text('Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          model.isLoading
              ? Container(
                  height: 40.0,
                  width: 230.0,
                  padding: EdgeInsets.all(5.0),
                  color: Color.fromRGBO(59, 70, 80, 1),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    _submitForm(model, context);
                  },
                  child: Container(
                    height: 40.0,
                    width: 230.0,
                    // color: Color.fromRGBO(0, 25, 45, .40),
                    color: Color.fromRGBO(59, 70, 80, 1),
                    alignment: Alignment.center,
                    child: Text('Accept Terms & Conditions',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
        ],
      );
    });
  }

  Future _submitForm(MainModel model, BuildContext context) async {
    Map<String, dynamic> successInformation = await model.createAccount();
    await model.createWallet();
    await model.createToken();
    _returnMessage(successInformation, context, model);
  }

  void _returnMessage(Map<String, dynamic> successInformation,
      BuildContext context, MainModel model) {
    if (successInformation['success']) {
      model.isLoading = true;
      model.signOut().then((_) {
        Navigator.of(context).pushReplacementNamed('/auth');
      });
      model.isLoading = false;
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oops! Something went wrong'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildMessage(context),
              SizedBox(height: 50.0),
              _buildControls(context)
            ],
          ),
        ),
      ),
    );
  }
}
