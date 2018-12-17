import 'package:flutter/material.dart';

class ProfileEditPage extends StatelessWidget {
  final Function _navigateForward;

  ProfileEditPage(this._navigateForward);

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _targetWidth = _deviceWidth > 550.0 ? 500.0 : _deviceWidth * .90;

    return Container(
        child: Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          width: _targetWidth,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'First Name',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Last Name',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                keyboardType: TextInputType.phone,
                maxLength: 9,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Mobile Phone',
                    prefixText: '+233 ',
                    suffixIcon: Icon(Icons.phone_android)),
              ),
              TextField(
                  keyboardType: TextInputType.phone,
                  maxLength: 9,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Other Phone',
                    prefixText: '+233 ',
                    suffixIcon: Icon(Icons.local_phone),
                  )),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 80.0,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    color: Theme.of(context).primaryColor,
                    alignment: Alignment.center,
                    child: Text('Cancel',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateForward();
                    },
                    child: Container(
                      height: 40.0,
                      width: 120.0,
                      // color: Color.fromRGBO(0, 25, 45, .40),
                      color: Color.fromRGBO(59, 70, 80, 1),
                      alignment: Alignment.center,
                      child: Text('Continue',
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
    ));
  }
}
