import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/shared/confirm_transaction_bottom_modal.dart';
import 'package:bank_app/widgets/shared/transaction_success_alert.dart';
import 'package:bank_app/widgets/ui_elements/wallet_card_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FundsLoanPage extends StatefulWidget {
  final MainModel _model;

  FundsLoanPage(this._model);

  @override
  _FundsLoanPageState createState() => _FundsLoanPageState();
}

class _FundsLoanPageState extends State<FundsLoanPage> {
  Map<String, dynamic> _formData = {
    'amount': 0.0,
    'accountNumber': null,
    'fromAccount': null,
    'toAccount': null,
    'payBackDate': null
  };

  DateTime _pickedDate;

  Map<String, dynamic> _transactionDetails;
  TextEditingController _payBackDateController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget._model.fetchWallet();
    super.initState();
  }

  Future _selectPayBackDate(BuildContext context) async {
    _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(new Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 35)),
        initialDatePickerMode: DatePickerMode.day);
    if (_pickedDate != null) {
      setState(() {
        _payBackDateController.text =
            '${_pickedDate.day}/${_pickedDate.month}/${_pickedDate.year}';
      });
    }
  }

  Future _buildConfirmBottomSheetModal(
      BuildContext context, Function submitForm) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ConfirmTransactionBottomModal(
            _transactionDetails,
            submitForm,
            requestingForm: 'LOAN',
          );
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

  Widget _buildLoanAmountMaterialContainer() {
    return Material(
      elevation: 1.0,
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(20.0),
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Get Loan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildLoanAmountTextField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionDetailsMaterialContainer(MainModel model) {
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
            SizedBox(height: 20.0),
            Text('When can you pay back?',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildPayBackDate(),
            SizedBox(height: 30.0),
            _buildFormControls(model)
          ],
        ),
      ),
    );
  }

  Widget _buildLoanAmountTextField() {
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
          suffix: Text(' GHC Loan Amount'),
          filled: true,
          fillColor: Theme.of(context).cardColor),
      validator: (String value) {
        if (value.isEmpty || double.parse(value) <= 0) {
          return 'Loan amount is required!';
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
        keyboardType: TextInputType.number,
        initialValue: model.wallet != null
            ? model.wallet.accountNumber
            : 'No Account Number',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_balance),
            suffixStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold)),
        validator: (String value) {
          if (value.isEmpty || value.length != 9) {
            return 'Invalid account number!';
          }
        },
        onSaved: (String value) {
          _formData['accountNumber'] = value;
          _formData['fromAccount'] = value;
          _formData['toAccount'] = value;
        },
      ),
    );
  }

  Widget _buildPayBackDate() {
    return GestureDetector(
      onTap: () {
        _selectPayBackDate(context);
      },
      child: AbsorbPointer(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _payBackDateController,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
          decoration: InputDecoration(
              hintText: 'Select Payback Date',
              prefixIcon: Icon(Icons.calendar_today)),
          validator: (String value) {
            if (value.isEmpty || _payBackDateController.text.isEmpty) {
              return 'Payback date is required!';
            }
          },
        ),
      ),
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
              'transactionType': 'LOAN',
              'amount': _formData['amount'],
              'fromAccount': _formData['fromAccount'],
              'toAccount': _formData['toAccount'],
              'payBackDate': _payBackDateController.text,
            };

            await _buildConfirmBottomSheetModal(context, _submitForm);
            // await _submitForm();
            // await _buildConfirmBottomSheetModal(context);
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

    Map<String, dynamic> successInformation = await widget._model.createLoan(
      _formData['amount'],
      _formData['accountNumber'],
      _formData['fromAccount'],
      _formData['toAccount'],
      _pickedDate,
    );

    _returnMessage(successInformation, widget._model);
    _formKey.currentState.reset();
    _payBackDateController.text = '';
    _pickedDate = null;
  }

  _returnMessage(Map<String, dynamic> successInformation, MainModel model) {
    if (successInformation['success']) {
      Map<String, String> message = {
        'title': successInformation['message'],
        'subtitle':
            'Your LOAN transaction request will be processed after being reviewed. We will notify you on process completion and the requested loan amount will be credited to your account'
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
                title: Text('Loan'),
                backgroundColor: Theme.of(context).primaryColor),
            body: ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      WalletCardStack(model: model),
                      _buildLoanAmountMaterialContainer(),
                      _buildTransactionDetailsMaterialContainer(model),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
