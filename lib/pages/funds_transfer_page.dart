import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/ui_elements/wallet_card_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FundsTransferPage extends StatefulWidget {
  final MainModel _model;

  const FundsTransferPage(this._model);

  @override
  _FundsTransferPageState createState() => _FundsTransferPageState();
}

class _FundsTransferPageState extends State<FundsTransferPage> {
  Map<String, dynamic> _formData = {
    'amount': 0.0,
    'accountNumber': null,
    'fromAccount': null,
    'toAccount': null
  };

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget._model.fetchWallet();
    super.initState();
  }

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

  Widget _buildTransferFundsMaterialContainer() {
    return Material(
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
            _buildTransferFundsTextField(),
          ],
        ),
      ),
    );
  }

  Widget _buildFromAccountMaterialContainer() {
    return Material(
      elevation: 1.0,
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('FROM',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey),
            Text('My Account',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildFromAccountTextField(),
          ],
        ),
      ),
    );
  }

  Widget _buildToAccountMaterialContainer() {
    return Material(
      elevation: 1.0,
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('TO',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey),
            Text('Recipient',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildToAccountFormField(),
            SizedBox(height: 30.0),
            _buildFormControls()
          ],
        ),
      ),
    );
  }

  Widget _buildTransferFundsTextField() {
    return TextFormField(
      maxLength: 7,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Amount',
          prefixIcon: Icon(Icons.account_balance_wallet),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          suffix: Text(' GHC Transfer Amount'),
          filled: true,
          fillColor: Theme.of(context).cardColor),
      onSaved: (String value) {
        _formData['amount'] = double.parse(value);
      },
    );
  }

  Widget _buildFromAccountTextField() {
    return AbsorbPointer(
      child: TextFormField(
        maxLength: 9,
        initialValue: '703430692',
        keyboardType: TextInputType.number,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_balance),
            suffixStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
            suffix: Text(' Current Balance')),
        onSaved: (String value) {
          _formData['fromAccount'] = value;
        },
      ),
    );
  }

  Widget _buildToAccountFormField() {
    return TextFormField(
      maxLength: 9,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Recipients A/C',
          prefixIcon: Icon(Icons.transfer_within_a_station),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          suffix: Text(' Account Transfer')),
      onSaved: (String value) {
        _formData['toAccount'] = value;
      },
    );
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
            // await _buildConfirmBottomSheetModal(context);
            _submitForm();
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
    );
  }

  void _submitForm() {
    _formKey.currentState.save();
    print(_formData.values);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
              title: Text('Transfer'),
              backgroundColor: Theme.of(context).primaryColor),
          body: ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    WalletCardStack(model: model),
                    _buildTransferFundsMaterialContainer(),
                    _buildFromAccountMaterialContainer(),
                    SizedBox(height: 20.0),
                    _buildToAccountMaterialContainer()
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
