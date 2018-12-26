import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/shared/transaction_success_alert.dart';
import 'package:bank_app/widgets/ui_elements/wallet_card_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FundsDepositPage extends StatefulWidget {
  final MainModel _model;

  FundsDepositPage(this._model);

  @override
  _FundsDepositPageState createState() => _FundsDepositPageState();
}

class _FundsDepositPageState extends State<FundsDepositPage> {
  DateTime _pickedDate;

  final Map<String, dynamic> _formData = {
    'amount': 0.0,
    'accountNumber': null,
    'transactionNumber': null,
    'transactionDate': null
  };

  TextEditingController _transactionDateController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    widget._model.fetchWallet();
    super.initState();
  }

  Future _selectTransactionDate(BuildContext context) async {
    _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(new Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 35)),
        initialDatePickerMode: DatePickerMode.day);
    if (_pickedDate != null) {
      setState(() {
        _transactionDateController.text =
            '${_pickedDate.day}/${_pickedDate.month}/${_pickedDate.year}';
      });
    }
  }

  Future _buildConfirmBottomSheetModal(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return 
        });
  }

  Future _buildSuccessfulTransactionAlert(
      BuildContext context, Map<String, String> message, MainModel model) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return TransactionSuccessAlert(message, model);
        });
  }

  Widget _buildTransactionDetails(BuildContext context, MainModel model) {
    return Material(
      elevation: 1.0,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Transaction Details',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey),
            Text('Deposit Amount',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildDepositAmountFormField(),
            SizedBox(height: 20.0),
            Text('Transaction Number',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildTransactionNumberFormField(),
            SizedBox(height: 20.0),
            Text('Transaction Date',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildTransactionDateFormField(),
            SizedBox(height: 30.0),
            _buildFormControls(context, model)
          ],
        ),
      ),
    );
  }

  Widget _buildDepositFundFormField(MainModel model) {
    return AbsorbPointer(
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: model.wallet != null
            ? model.wallet.accountNumber
            : 'No Account Selected!',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
        decoration: InputDecoration(
            hintText: 'Recieving Account',
            prefixIcon: Icon(Icons.account_balance),
            suffixStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
            suffix: Text(' Current Balance'),
            filled: true,
            fillColor: Theme.of(context).cardColor),
        onSaved: (String value) {
          _formData['accountNumber'] = value;
        },
      ),
    );
  }

  _buildDepositAmountFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Amount',
          prefixIcon: Icon(Icons.monetization_on),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          suffix: Text(' GHC Deposit Amount')),
      onSaved: (String value) {
        _formData['amount'] = value;
      },
    );
  }

  _buildTransactionNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Transaction Number',
          prefixIcon: Icon(Icons.format_list_numbered_rtl),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold)),
      onSaved: (String value) {
        _formData['transactionNumber'] = value;
      },
    );
  }

  _buildTransactionDateFormField() {
    return GestureDetector(
      onTap: () {
        _selectTransactionDate(context);
      },
      child: AbsorbPointer(
        child: TextField(
          keyboardType: TextInputType.number,
          controller: _transactionDateController,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
          decoration: InputDecoration(
              hintText: 'Select Transaction Date',
              prefixIcon: Icon(Icons.calendar_today)),
        ),
      ),
    );
  }

  Widget _buildFormControls(BuildContext context, MainModel model) {
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
          onTap: model.isLoading
              ? null
              : () async {
                  // await _buildConfirmBottomSheetModal(context);
                  _submitForm(model);
                },
          child: Container(
            height: 40.0,
            width: 200.0,
            // color: Color.fromRGBO(59, 70, 80, 1),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: model.isLoading
                ? CircularProgressIndicator()
                : Text('Confirm Deposit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Future _submitForm(MainModel model) async {
    _formKey.currentState.save();
    Map<String, dynamic> successInformation = await model.createDeposit(
        double.parse(_formData['amount']),
        _formData['accountNumber'],
        _formData['transactionNumber'],
        _pickedDate);

    _returnMessage(successInformation, model);
  }

  Future _returnMessage(
      Map<String, dynamic> successInformation, MainModel model) async {
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
        return Scaffold(
          appBar: AppBar(
              title: Text('Deposit'),
              backgroundColor: Theme.of(context).primaryColor),
          body: ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    WalletCardStack(model: model),
                    // SizedBox(height: 30.0),
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
                              'Deposit Funds',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            _buildDepositFundFormField(model),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    _buildTransactionDetails(context, model)
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
