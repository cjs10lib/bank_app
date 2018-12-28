import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/shared/confirm_transaction_bottom_modal.dart';
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

  Map<String, dynamic> _transactionDetails;

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
        initialDate: DateTime.now(), // Highlighted Date
        firstDate: DateTime.now().subtract(new Duration(days: 7)), // Date range
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day);
    if (_pickedDate != null) {
      setState(() {
        _transactionDateController.text =
            '${_pickedDate.day}/${_pickedDate.month}/${_pickedDate.year}';
      });
    }
  }

  Future _buildConfirmBottomSheetModal(
      BuildContext context, Function submitForm) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ConfirmTransactionBottomModal(_transactionDetails, submitForm, requestingForm: 'DEPOSIT',);
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
        validator: (String value) {
          if (value.isEmpty || value.length != 9) {
            return 'Sorry! Your account number is invalid!';
          }
        },
        onSaved: (String value) {
          _formData['accountNumber'] = value;
        },
      ),
    );
  }

  _buildDepositAmountFormField() {
    return TextFormField(
      maxLength: 7,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Amount',
          prefixIcon: Icon(Icons.monetization_on),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          suffix: Text(' GHC Deposit Amount')),
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

  _buildTransactionNumberFormField() {
    return TextFormField(
      maxLength: 10,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Transaction Number',
          prefixIcon: Icon(Icons.format_list_numbered_rtl),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold)),
      validator: (String value) {
        if (value.isEmpty || value.length != 10) {
          return 'Sorry! Your transaction number is invalid!';
        }
      },
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
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _transactionDateController,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
          decoration: InputDecoration(
              hintText: 'Select Transaction Date',
              prefixIcon: Icon(Icons.calendar_today)),
          validator: (String value) {
            if (_transactionDateController.text.isEmpty) {
              return 'Date of transfer transaction is required!';
            }
          },
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
          onTap: () async {
            if (!_formKey.currentState.validate()) {
              return;
            }
            _formKey.currentState.save();

            _transactionDetails = {
              'profileImage': model.profileImage,
              'transactionType': 'DEPOSIT',
              'amount': _formData['amount'],
              'transactionNumber': _formData['transactionNumber'],
              'fromAccount': _formData['transactionNumber'],
              'toAccount': _formData['accountNumber'],
              'transactionDate': _transactionDateController.text
            };
            await _buildConfirmBottomSheetModal(context, _submitForm);
          },
          child: Container(
            height: 40.0,
            width: 200.0,
            // color: Color.fromRGBO(59, 70, 80, 1),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: Text('Confirm Deposit',
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
    Map<String, dynamic> successInformation = await widget._model.createDeposit(
        _formData['amount'],
        _formData['accountNumber'],
        _formData['transactionNumber'],
        _pickedDate);

    _returnMessage(successInformation, widget._model);
    _formKey.currentState.reset(); // Clear formState
    _transactionDateController.clear();
    _pickedDate = null;
  }

  _returnMessage(Map<String, dynamic> successInformation, MainModel model) {
    if (successInformation['success']) {
      Map<String, String> message = {
        'title': successInformation['message'],
        'subtitle':
            'Your deposit transaction request will be processed after being reviewed. We will notify you on process completion and your account will be credited on successful process completion.'
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
                title: Text('Deposit'),
                backgroundColor: Theme.of(context).primaryColor),
            body: SafeArea(
              child: ListView(
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
                        // SizedBox(height: 30.0),
                        _buildTransactionDetails(context, model)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
