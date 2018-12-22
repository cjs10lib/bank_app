import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FundsLoanPage extends StatefulWidget {
  @override
  _FundsLoanPageState createState() => _FundsLoanPageState();
}

class _FundsLoanPageState extends State<FundsLoanPage> {
  String _payBackDate = '';

  Future _buildConfrimBottomSheetModal(BuildContext context, MainModel model) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            // height: 600.0,
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
                      backgroundImage: NetworkImage(model.profileImage)),
                ),
                Text('LOAN',
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
                    Text('GHc',
                        style: TextStyle(
                            color: Color.fromRGBO(59, 70, 80, 1),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('PAY BACK',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Column(
                      children: <Widget>[
                        Text(
                          'GHc1030.00',
                          style: TextStyle(
                              color: Color.fromRGBO(59, 70, 80, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(20/10/2019)',
                          style:
                              TextStyle(color: Color.fromRGBO(59, 70, 80, 1)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('INTEREST RATE',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      '3% (GHc30.00)',
                      style: TextStyle(color: Color.fromRGBO(59, 70, 80, 1)),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text('Terms & Conditions Applies!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
                SizedBox(height: 20.0),
                Container(
                  height: 40.0,
                  width: 200.0,
                  // color: Color.fromRGBO(59, 70, 80, 1),
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: Text('Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        });
  }

  Future _selectLoanPaybackDate() async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(new Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 35)),
        initialDatePickerMode: DatePickerMode.day);
    if (pickedDate != null) {
      setState(() {
        _payBackDate =
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        }, child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          width: double.infinity,
                          color: Theme.of(context).primaryColor,
                        ),
                        Positioned(
                          bottom: 50.0,
                          right: 100.0,
                          child: Container(
                            height: 400.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 25, 45, .40),
                                borderRadius: BorderRadius.circular(200.0)),
                          ),
                        ),
                        Positioned(
                          bottom: 100.0,
                          left: 200.0,
                          child: Container(
                            height: 400.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 25, 45, .40),
                                borderRadius: BorderRadius.circular(200.0)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 20.0, right: 20.0, left: 20.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        border: Border.all(
                                            color: Colors.white, width: 2.0)),
                                    child: Hero(
                                      tag: 'profile-image',
                                      child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(model.profileImage)),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 40.0),
                              Material(
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(5.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      color: Color.fromRGBO(59, 70, 80, 1)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Amount',
                                      prefix: Text('GHC ')),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 50.0),
                    Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        // height: 130.0,
                        color: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Text('WHEN TO PAY BACK?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(height: 5.0),
                            FlatButton(
                                child: Text(
                                    _payBackDate != ''
                                        ? _payBackDate
                                        : 'Select Date',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                onPressed: _selectLoanPaybackDate),
                            SizedBox(height: 30.0),
                            Text('Terms & Conditions',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(height: 30.0),
                            Text(
                                'Every loan issued, to our clients, is governed by 1999 constitutional laws',
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                  onTap: () {
                                    _buildConfrimBottomSheetModal(
                                        context, model);
                                  },
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
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
