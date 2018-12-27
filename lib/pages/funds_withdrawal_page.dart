import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/ui_elements/wallet_card_stack.dart';
import 'package:flutter/material.dart';

class FundsWithdrawalPage extends StatefulWidget {
  final MainModel _model;

  FundsWithdrawalPage(this._model);

  @override
  FundsWithdrawalPageState createState() {
    return new FundsWithdrawalPageState();
  }
}

class FundsWithdrawalPageState extends State<FundsWithdrawalPage> {
  @override
  void initState() {
    widget._model.fetchWallet();
    super.initState();
  }

  Future _buildConfirmBottomSheetModal(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container();
        });
  }

  Widget _buildTransactionDetails() {
    return Material(
      elevation: 1.0,
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('RECIPIENT ACCOUNT',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey),
            Text('My Account',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildRecipientAccountTextField(),
            SizedBox(height: 30.0),
            _buildFormControls()
          ],
        ),
      ),
    );
  }

  Widget _buildFundsWithdrawalAmountTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Amount',
          prefixIcon: Icon(Icons.monetization_on),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          suffix: Text(' GHC Withdrawal Amount'),
          filled: true,
          fillColor: Theme.of(context).cardColor),
    );
  }

  Widget _buildRecipientAccountTextField() {
    return AbsorbPointer(
        child: TextFormField(
      keyboardType: TextInputType.number,
      initialValue: '7034306929',
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_balance),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          suffix: Text('MOMO Transaction')),
    ));
  }

  Widget _buildFormControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: 40.0,
            width: 80.0,
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
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
            child: Text('Confirm Request',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Withdraw'),
          backgroundColor: Theme.of(context).primaryColor),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              WalletCardStack(
                model: widget._model,
              ),
              Material(
                elevation: 1.0,
                color: Theme.of(context).primaryColor,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Funds Withdrawal',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      _buildFundsWithdrawalAmountTextField(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              _buildTransactionDetails()
            ],
          )
        ],
      ),
    );
  }
}
