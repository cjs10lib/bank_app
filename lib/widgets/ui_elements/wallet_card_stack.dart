import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WalletCardStack extends StatefulWidget {
  final MainModel model;

  WalletCardStack({this.model});

  @override
  WalletCardStackState createState() {
    return new WalletCardStackState();
  }
}

class WalletCardStackState extends State<WalletCardStack> {
  @override
  void initState() {
    widget.model.fetchWallet();
    super.initState();
  }

  _buildBaseStackContainer(BuildContext context) {
    return Container(
      height: 250.0,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _buildWalletCardContainer(BuildContext context, MainModel model) {
    return Material(
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
                  _buildCardTitleRow(),
                  _buildCardNumberRow(model),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildCardAccountNameColumn(model),
                      _buildCardAccountBalance(model),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCardTitleRow() {
    return Row(
      children: <Widget>[
        Text('Wallet',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold))
      ],
    );
  }

  _buildCardNumberRow(MainModel model) {
    // final firstNumber = _model.authenticatedUser.uid.substring(0, 4);
    // final secondNumber = '233${_model.wallet.accountNumber.substring(0, 1)}';
    // final thirdNumber = _model.wallet.accountNumber.substring(2, 3);
    final String _fourthNumber = widget.model.wallet != null
        ? model.wallet.accountNumber.substring(5)
        : null;

    print(_fourthNumber);

    // '2332 7074 7772'

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('****', style: TextStyle(fontSize: 30.0, color: Colors.white)),
        Text('****', style: TextStyle(fontSize: 30.0, color: Colors.white)),
        Text('****', style: TextStyle(fontSize: 30.0, color: Colors.white)),
        _fourthNumber == null
            ? CircularProgressIndicator()
            : Text(_fourthNumber,
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
      ],
    );
  }

  Widget _buildCardAccountNameColumn(MainModel model) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Accountholder Name',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
        model.profile == null
            ? CircularProgressIndicator()
            : Text(
                '${model.profile.firstname} ${model.profile.lastname}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
      ],
    );
  }

  Widget _buildCardAccountBalance(MainModel model) {
    return Column(
      children: <Widget>[
        Text(
          'Wallet Balance',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
        model.profile == null
            ? CircularProgressIndicator()
            : Text(
                'GHC ${model.wallet.balance.toString()}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildBaseStackContainer(context),
            _buildWalletCardContainer(context, model)
          ],
        );
      },
    );
  }
}
