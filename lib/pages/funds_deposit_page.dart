import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/ui_elements/wallet_card_stack.dart';
import 'package:flutter/material.dart';

class FundsDepositPage extends StatefulWidget {
  final MainModel _model;

  FundsDepositPage(this._model);

  @override
  _FundsDepositPageState createState() => _FundsDepositPageState();
}

class _FundsDepositPageState extends State<FundsDepositPage> {
  DateTime _pickedDate;

  TextEditingController _transactionDateController = TextEditingController();

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
          return Container(
            height: 350.0,
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
                Text('DEPOSIT',
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
                  child: Text('1234567890',
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
                        Text(
                          '703430692',
                          style: TextStyle(
                              color: Color.fromRGBO(59, 70, 80, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(20/12/2018)',
                          style:
                              TextStyle(color: Color.fromRGBO(59, 70, 80, 1)),
                        ),
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

  Widget _buildTransactionDetails(BuildContext context) {
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
            _buildFormControls(context)
          ],
        ),
      ),
    );
  }

  Widget _buildDepositFundFormField() {
    return AbsorbPointer(
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: '7034306929',
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
      ),
    );
  }

  _buildDepositAmountFormField() {
    return TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Amount',
          prefixIcon: Icon(Icons.monetization_on),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          suffix: Text(' GHC Deposit Amount')),
    );
  }

  _buildTransactionNumberFormField() {
    return TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          hintText: 'Enter Transaction Number',
          prefixIcon: Icon(Icons.format_list_numbered_rtl),
          suffixStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold)),
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
        ),
      ),
    );
  }

  Widget _buildFormControls(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Deposit'),
          backgroundColor: Theme.of(context).primaryColor),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              WalletCardStack(model: widget._model),
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
                      _buildDepositFundFormField(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              _buildTransactionDetails(context)
            ],
          )
        ],
      ),
    );
  }
}
