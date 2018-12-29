import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionLog extends StatelessWidget {
  final Map<String, dynamic> _transactionDetails;

  TransactionLog(this._transactionDetails);

  @override
  Widget build(BuildContext context) {
    String _transactionType = _transactionDetails['transactionType'];
    String _formatedDate = DateFormat('EEEE, MMMM d, yyy')
        .format(_transactionDetails['lastUpdate']);
    List<String> _amount = _transactionDetails['amount'].toString().split('.');

    return Column(
      children: <Widget>[
        Material(
          elevation: 1.0,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_formatedDate, style: TextStyle(color: Colors.grey)),
                    Text(_transactionType,
                        style:
                            TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                    Text('My Account', style: TextStyle(color: Colors.grey))
                  ],
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(_amount[0],
                        style: TextStyle(fontSize: 35.0, color: Colors.red)),
                    SizedBox(width: 5.0),
                    Text(_amount[1], style: TextStyle(color: Colors.red))
                  ],
                )),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}
