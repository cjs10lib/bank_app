import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/shared/confirm_transaction_bottom_modal.dart';
import 'package:bank_app/widgets/shared/transaction_success_alert.dart';
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

  Map<String, dynamic> _transactionDetails;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget._model.fetchWallet();
    super.initState();
  }

  Future _buildConfirmBottomSheetModal(
      BuildContext context, Function submitForm) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ConfirmTransactionBottomModal(_transactionDetails, submitForm, requestingForm: 'TRANSFER',);
        });
  }

  Future _buildSuccessfulTransactionAlert(
      BuildContext context, Map<String, String> message, MainModel model) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return TransactionSuccessAlert(message, model);
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

  Widget _buildFromAccountMaterialContainer(MainModel model) {
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
            _buildFromAccountTextField(model),
          ],
        ),
      ),
    );
  }

  Widget _buildToAccountMaterialContainer(MainModel model) {
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
            _buildFormControls(model)
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

  Widget _buildFromAccountTextField(MainModel model) {
    return AbsorbPointer(
      child: TextFormField(
        maxLength: 9,
        initialValue: model.wallet != null ? model.wallet.accountNumber : 'No Account Number',
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

  Widget _buildFormControls(MainModel model) {
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
            if (!_formKey.currentState.validate()) {
              return;
            }
            _formKey.currentState.save();

            _transactionDetails = {
              'profileImage': model.profileImage,
              'transactionType': 'TRANSFER',
              'amount': _formData['amount'],
              'fromAccount': _formData['fromAccount'],
              'toAccount': _formData['toAccount'],
            };
            
            await _buildConfirmBottomSheetModal(context, _submitForm);
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

  Future _submitForm() async {
    _formKey.currentState.save();
    print(_formData.values);

    Map<String, dynamic> successInformation =
        await widget._model.createTransfer(
      _formData['amount'],
      _formData['accountNumber'],
      _formData['fromAccount'],
      _formData['toAccount'],
    );

    _returnMessage(successInformation, widget._model);
    _formKey.currentState.reset(); // Clear formSta
  }

  _returnMessage(Map<String, dynamic> successInformation, MainModel model) {
    if (successInformation['success']) {
      Map<String, String> message = {
        'title': successInformation['message'],
        'subtitle':
            'Your account will be credited on successful confirmaion of transaction.'
      };

      _buildSuccessfulTransactionAlert(context, message, model);
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
                    _buildFromAccountMaterialContainer(model),
                    SizedBox(height: 20.0),
                    _buildToAccountMaterialContainer(model)
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
