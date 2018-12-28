import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/shared/confirm_transaction_bottom_modal.dart';
import 'package:bank_app/widgets/shared/transaction_success_alert.dart';
import 'package:bank_app/widgets/ui_elements/wallet_card_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FundsWithdrawalPage extends StatefulWidget {
  final MainModel _model;

  FundsWithdrawalPage(this._model);

  @override
  FundsWithdrawalPageState createState() {
    return new FundsWithdrawalPageState();
  }
}

class FundsWithdrawalPageState extends State<FundsWithdrawalPage> {
  final Map<String, dynamic> _formData = {'amount': 0.0, 'accountNumber': null};
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
          return ConfirmTransactionBottomModal(_transactionDetails, submitForm);
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

  Widget _buildTransactionDetails(MainModel model) {
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
            _buildRecipientAccountTextField(model),
            SizedBox(height: 30.0),
            _buildFormControls(model)
          ],
        ),
      ),
    );
  }

  Widget _buildFundsWithdrawalAmountTextField() {
    return TextFormField(
      maxLength: 4,
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Amount is required!';
        }
      },
      onSaved: (String value) {
        _formData['amount'] = double.parse(value);
      },
    );
  }

  Widget _buildRecipientAccountTextField(MainModel model) {
    return AbsorbPointer(
        child: TextFormField(
          maxLength: 10,
      keyboardType: TextInputType.number,
      initialValue: model.profile != null ? model.profile.mobilePhone : 'Invalid MOMO Number',
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_balance),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          suffix: Text('MOMO Transaction')),
      validator: (String value) {
        if (value.isEmpty || value.length != 9) {
          return 'Sorry! Your account number is invalid!';
        }
      },
      onSaved: (String value) {
        _formData['accountNumber'] = value;
      },
    ));
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
              'transactionType': 'WITHDRAWAL',
              'amount': _formData['amount'],
              'fromAccount': _formData['accountNumber'],
              'toAccount': _formData['accountNumber'],
            };
            await _buildConfirmBottomSheetModal(context, _submitForm);
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

  Future _submitForm() async {
    if (!_formKey.currentState.validate()) {
      Navigator.of(context).pop();
      return;
    }
    _formKey.currentState.save();

    Map<String, dynamic> successInformation = await widget._model
        .createWithdrawal(_formData['amount'], _formData['accountNumber']);

    _returnMessage(successInformation, widget._model);
    _formKey.currentState.reset();
  }

  _returnMessage(Map<String, dynamic> successInformation, MainModel model) {
    if (successInformation['success']) {
      Map<String, String> message = {
        'title': successInformation['message'],
        'subtitle':
            'Your account will be debited on successful confirmaion of transaction and the money will be transfered to your MOMO account'
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
    return Scaffold(
        appBar: AppBar(
            title: Text('Withdraw'),
            backgroundColor: Theme.of(context).primaryColor),
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
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
                      // SizedBox(height: 30.0),
                      _buildTransactionDetails(model)
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}
