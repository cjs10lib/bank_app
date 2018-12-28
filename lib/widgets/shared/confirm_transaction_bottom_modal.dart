import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ConfirmTransactionBottomModal extends StatelessWidget {
  final Map<String, dynamic> _transactionDetails;
  final Function _submitForm;

  final String requestingForm;

  ConfirmTransactionBottomModal(this._transactionDetails, this._submitForm,
      {this.requestingForm});

  Widget _buildProfileImageContainer() {
    return Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: FadeInImage(
            image: NetworkImage(_transactionDetails['profileImage']),
            placeholder: AssetImage('assets/avatar/avatar.png'),
          ),
        ));
  }

  Widget _buildTransactionAmountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_transactionDetails['amount'].toString(),
            style: TextStyle(
                color: Color.fromRGBO(59, 70, 80, 1), fontSize: 50.0)),
        SizedBox(width: 10.0),
        Text('GHC',
            style: TextStyle(
                color: Color.fromRGBO(59, 70, 80, 1),
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTransactionNumber(BuildContext context) {
    return _transactionDetails['transactionNumber'] == null
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0)),
            // _transactionDetails['transactionNumber']
            child: Text(_transactionDetails['transactionNumber'].toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0)),
          );
  }

  Widget _buildTransactionFromAccountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('From:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 50.0),
        Text(
          _transactionDetails['fromAccount'].toString(),
          style: TextStyle(
              color: Color.fromRGBO(59, 70, 80, 1),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTransactionToAccountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('To:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 50.0),
        Text(
          _transactionDetails['toAccount'].toString(),
          style: TextStyle(
              color: Color.fromRGBO(59, 70, 80, 1),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTransactionDate() {
    return _transactionDetails['transactionDate'] == null
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('(${_transactionDetails['transactionDate'].toString()})',
                  style: TextStyle(
                      color: Color.fromRGBO(59, 70, 80, 1),
                      fontWeight: FontWeight.bold)),
            ],
          );
  }

  Widget _buildControls(BuildContext context, MainModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
                  await _submitForm();
                },
          child: Container(
            height: 40.0,
            width: 150.0,
            // color: Color.fromRGBO(59, 70, 80, 1),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: model.isLoading
                ? CircularProgressIndicator()
                : Text('Submit Request',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildDepositConfirmBottomModal(
      BuildContext context, MainModel model) {
    return Container(
      height: 350.0,
      width: 200.0,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _buildProfileImageContainer(),
          Text(_transactionDetails['transactionType'],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          _buildTransactionAmountRow(),
          _buildTransactionNumber(context),
          SizedBox(height: 20.0),
          _buildTransactionFromAccountRow(),
          _buildTransactionToAccountRow(),
          SizedBox(height: 10.0),
          _buildTransactionDate(),
          SizedBox(height: 20.0),
          _buildControls(context, model)
        ],
      ),
    );
  }

  Widget _buildWithdrawConfirmBottomModal(
      BuildContext context, MainModel model) {
    return Container(
      height: 270.0,
      width: 200.0,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _buildProfileImageContainer(),
          Text(_transactionDetails['transactionType'],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          _buildTransactionAmountRow(),
          // SizedBox(height: 20.0),
          _buildTransactionFromAccountRow(),
          _buildTransactionToAccountRow(),
          SizedBox(height: 20.0),
          _buildControls(context, model)
        ],
      ),
    );
  }

  Widget _buildTransferConfirmBottomModal(
      BuildContext context, MainModel model) {
    return Container(
      height: 270.0,
      width: 200.0,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _buildProfileImageContainer(),
          Text(_transactionDetails['transactionType'],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          _buildTransactionAmountRow(),
          // SizedBox(height: 20.0),
          _buildTransactionFromAccountRow(),
          _buildTransactionToAccountRow(),
          SizedBox(height: 20.0),
          _buildControls(context, model)
        ],
      ),
    );
  }

  Widget _displayMode(BuildContext context, MainModel model) {
    if (requestingForm == 'DEPOSIT') {
      return _buildDepositConfirmBottomModal(context, model);
    } else if (requestingForm == 'WITHDRAW') {
      return _buildWithdrawConfirmBottomModal(context, model);
    } else {
      return _buildTransferConfirmBottomModal(context, model);
    }
    // return Container();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _displayMode(context, model);
    });
  }
}
