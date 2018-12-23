import 'package:bank_app/widgets/ui_elements/wallet_card_stack.dart';
import 'package:flutter/material.dart';

class FundsTransferPage extends StatelessWidget {
  Future _buildConfirmBottomSheetModal(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 370.0,
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
                Text('Transfer',
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
                  child: Text('20/12/2018',
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
                        Text('703430692',
                            style: TextStyle(
                                color: Color.fromRGBO(59, 70, 80, 1),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.compare_arrows),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('RECIPIENT',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 50.0),
                    Column(
                      children: <Widget>[
                        Text(
                          '703430692',
                          style: TextStyle(
                              color: Color.fromRGBO(59, 70, 80, 1),
                              fontWeight: FontWeight.bold),
                        )
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Transfer'),
          backgroundColor: Theme.of(context).primaryColor),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              WalletCardStack(),
              Material(
                elevation: 1.0,
                color: Theme.of(context).primaryColor,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Transfer Funds',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0),
                        decoration: InputDecoration(
                            hintText: 'Enter Amount',
                            prefixIcon: Icon(Icons.account_balance_wallet),
                            suffixStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                            suffix: Text(' GHC Transfer Amount'),
                            filled: true,
                            fillColor: Theme.of(context).cardColor),
                      ),
                    ],
                  ),
                ),
              ),
              Material(
                elevation: 1.0,
                color: Theme.of(context).cardColor,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('FROM',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                      Divider(color: Colors.grey),
                      Text('My Account',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                      AbsorbPointer(
                        child: TextFormField(
                          initialValue: '7034306929',
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.0),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_balance),
                              suffixStyle: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                              suffix: Text(' Current Balance')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Material(
                elevation: 1.0,
                color: Theme.of(context).cardColor,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('TO',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                      Divider(color: Colors.grey),
                      Text('Recipient',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                      TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0),
                        decoration: InputDecoration(
                            hintText: 'Enter Recipients A/C',
                            prefixIcon: Icon(Icons.transfer_within_a_station),
                            suffixStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                            suffix: Text(' Account Transfer')),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                            onTap: () async {
                              await _buildConfirmBottomSheetModal(context);
                            },
                            child: Container(
                              height: 40.0,
                              width: 200.0,
                              // color: Color.fromRGBO(59, 70, 80, 1),
                              color: Theme.of(context).primaryColor,
                              alignment: Alignment.center,
                              child: Text('Confirm Transfer',
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
              )
            ],
          )
        ],
      ),
    );
  }
}
