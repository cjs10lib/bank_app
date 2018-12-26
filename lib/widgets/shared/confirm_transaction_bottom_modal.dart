import 'package:flutter/material.dart';

class ConfirmTransactionBottomModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 350.0,
            width: 200.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar/avatar.png')),
                ),
                Text('DEPOSIT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('1000.00',
                        style: TextStyle(
                            color: Color.fromRGBO(59, 70, 80, 1),
                            fontSize: 50.0)),
                    SizedBox(width: 10.0),
                    Text('GHC',
                        style: TextStyle(
                            color: Color.fromRGBO(59, 70, 80, 1),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('1234567890',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0)),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('ACCOUNT',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 50.0),
                    Column(
                      children: <Widget>[
                        Text(
                          '703430692',
                          style: TextStyle(
                              color: Color.fromRGBO(59, 70, 80, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(20/12/2018)',
                          style:
                              TextStyle(color: Color.fromRGBO(59, 70, 80, 1)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 40.0,
                        width: 80.0,
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        color: Theme.of(context).errorColor,
                        alignment: Alignment.center,
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40.0,
                        width: 150.0,
                        // color: Color.fromRGBO(59, 70, 80, 1),
                        color: Theme.of(context).primaryColor,
                        alignment: Alignment.center,
                        child: Text('Submit Request',
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
          );
  }
}