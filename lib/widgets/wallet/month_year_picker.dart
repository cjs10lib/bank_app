import 'package:bank_app/models/month.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';

class MonthYearPicker extends StatefulWidget {
  final MainModel _model;

  MonthYearPicker(this._model);

  @override
  MonthYearPickerState createState() {
    return new MonthYearPickerState();
  }
}

class MonthYearPickerState extends State<MonthYearPicker> {
  List<int> _membershipLifeSpanYears;

  final List<Month> _months = [
    Month(title: 'January', value: 1),
    Month(title: 'Feburary', value: 2),
    Month(title: 'March', value: 3),
    Month(title: 'April', value: 4),
    Month(title: 'May', value: 5),
    Month(title: 'June', value: 6),
    Month(title: 'July', value: 7),
    Month(title: 'August', value: 8),
    Month(title: 'September', value: 9),
    Month(title: 'October', value: 10),
    Month(title: 'November', value: 11),
    Month(title: 'December', value: 12),
  ];

  int _displayedMonth = DateTime.now().month;
  int _displayedYear = DateTime.now().year;

  @override
  void initState() {
    _getMembershipLifeDuration(); // gets currentYear - (activatedYear * 2)
    super.initState();
  }

  @override
  void didUpdateWidget(MonthYearPicker oldWidget) {
    _getMembershipLifeDuration();

    // widget._model.fetchWallet();
    // widget._model.fetchWalletTransactions();

    // widget._model.fetchWalletTransactions(
    //     // fetch transactions based on query
    //     filterByMonthYear: true,
    //     transactionYear: _displayedYear,
    //     transactionMonth: _displayedMonth);
    print('did-Update MonthYear Picker');
    super.didUpdateWidget(oldWidget);
  }

  void _getMembershipLifeDuration() {
    if (widget._model.accountStatus == null) {
      return;
    }

    final DateTime activatedDate = widget._model.accountStatus.lastUpdate;
    final int activatedYear = activatedDate.year;

    final List<int> years = [];
    for (var i = activatedYear; i <= DateTime.now().year; i++) {
      print(i);
      years.add(i);
    }
    _membershipLifeSpanYears = years;
  }

  Widget _buildMonthDropDown() {
    return DropdownButton<int>(
      elevation: 2,
      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
      items: _months.map((Month month) {
        return DropdownMenuItem<int>(
          child: Text(month.title),
          value: month.value,
        );
      }).toList(),
      onChanged: (int value) {
        setState(() {
          _displayedMonth = value;
          widget._model.fetchWalletTransactions(
              // fetch transactions based on query when selected
              filterByMonthYear: true,
              transactionYear: _displayedYear,
              transactionMonth: _displayedMonth);
        });
      },
      value: _displayedMonth,
    );
  }

  Widget _buildYearDropDown() {
    return DropdownButton<int>(
      elevation: 2,
      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
      items: _membershipLifeSpanYears.map((int year) {
        return DropdownMenuItem(
          child: Text(year.toString()),
          value: year,
        );
      }).toList(),
      onChanged: (int value) {
        setState(() {
          _displayedYear = value;
          widget._model.fetchWalletTransactions(
              // fetch transactions based on query when selected
              filterByMonthYear: true,
              transactionYear: _displayedYear,
              transactionMonth: _displayedMonth);
        });
      },
      value: _displayedYear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[_buildMonthDropDown(), _buildYearDropDown()],
    );
  }
}
