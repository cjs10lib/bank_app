import 'package:flutter/material.dart';

class AcceptTermsPage extends StatelessWidget {
  final Function _navigateBackwards;

  AcceptTermsPage(this._navigateBackwards);

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _targetWidth = _deviceWidth > 550.0 ? 500.0 : _deviceWidth * .90;

    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: _targetWidth,
                child: Text(
                    'Thank you for signing up. We will review your credentials and notify you on approval.',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _navigateBackwards();
                    },
                    child: Container(
                      height: 40.0,
                      width: 80.0,
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                      color: Theme.of(context).primaryColor,
                      alignment: Alignment.center,
                      child: Text('Back',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/tabs');
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
