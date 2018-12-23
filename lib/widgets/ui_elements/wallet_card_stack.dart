import 'package:flutter/material.dart';

class WalletCardStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 250.0,
          color: Theme.of(context).primaryColor,
        ),
        Material(
          elevation: 2.0,
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            height: 200.0,
            width: 350.0,
            // padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 150.0,
                  child: Container(
                      height: 400.0,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 25, 45, .40),
                          borderRadius: BorderRadius.circular(200.0))),
                ),
                Positioned(
                  left: 50.0,
                  bottom: 70.0,
                  child: Container(
                    height: 300.0,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 25, 45, .40),
                        borderRadius: BorderRadius.circular(150.0)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Wallet',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('****',
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white)),
                          Text('****',
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white)),
                          Text('****',
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white)),
                          Text('5678',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Accountholder Name',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                              Text(
                                'Charles Onwe',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Wallet Balance',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                              Text(
                                'GHc 100.53',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
