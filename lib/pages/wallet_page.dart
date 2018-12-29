import 'package:bank_app/models/month.dart';
import 'package:bank_app/models/wallet.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/wallet/month_year_picker.dart';
import 'package:bank_app/widgets/wallet/transaction_log.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WalletPage extends StatefulWidget {
  final MainModel _model;

  WalletPage(this._model);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    widget._model.fetchWallet();
    widget._model.fetchWalletTransactions();
    super.initState();
  }

  @override
  void didUpdateWidget(WalletPage oldWidget) {
    widget._model.fetchWallet();
    widget._model.fetchWalletTransactions();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildWalletLogDate(MainModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            iconSize: 30.0,
            onPressed: () {}),
        Column(children: <Widget>[
          Text('myWallet',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
          MonthYearPicker(model),
        ]),
        IconButton(
            icon: Icon(Icons.equalizer, color: Colors.white),
            iconSize: 30.0,
            onPressed: () {})
      ],
    );
  }

  Widget _buildWalletBalance(MainModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('GHc',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 10.0,
        ),
        model.wallet == null
            ? CircularProgressIndicator()
            : Text(
                model.wallet != null ? model.wallet.balance.toString() : '0.0',
                style: TextStyle(color: Colors.white, fontSize: 60.0)),
      ],
    );
  }

  Widget _buildWalletIncomeAndExpenditure() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.arrow_downward,
            color: Colors.green,
            size: 30.0,
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Text(
                'Credit',
                style: TextStyle(color: Colors.white),
              ),
              Text('GHc1.48',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        SizedBox(width: 50),
        Container(
          child: Icon(
            Icons.arrow_upward,
            color: Colors.red,
            size: 30.0,
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Text(
                'Debit',
                style: TextStyle(color: Colors.white),
              ),
              Text('GHc1.48',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ],
    );
  }

  Widget _builHeaderStack(BuildContext context, MainModel model) {
    return Stack(
      children: <Widget>[
        Container(
          height: 360.0,
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
              borderRadius: BorderRadius.circular(200.0),
              color: Color.fromRGBO(0, 25, 45, .40),
            ),
          ),
        ),
        Positioned(
          bottom: 150.0,
          left: 250.0,
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Color.fromRGBO(0, 25, 45, .40)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
          child: Column(
            children: <Widget>[
              _buildWalletLogDate(model),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(59, 70, 80, 1),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text('Current Balance',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 30.0),
              _buildWalletBalance(model),
              SizedBox(height: 30.0),
              _buildWalletIncomeAndExpenditure(),
              // SizedBox(height: 40.0),
            ],
          ),
        )
      ],
    );
  }

  Widget _pageContent(MainModel model) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          floating: true,
          snap: true,
          expandedHeight: 350.0,
          flexibleSpace: FlexibleSpaceBar(
            // title: Text('myWallet',
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 25.0,
            //                 fontWeight: FontWeight.bold)),
            background: _builHeaderStack(context, model),
            collapseMode: CollapseMode.parallax,
            centerTitle: true,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            model.isLoading
                ? [
                    Container(
                      padding: EdgeInsets.all(50.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ]
                : model.walletTransactions.map((WalletTransaction doc) {
                    Map<String, dynamic> transactionDetails = {
                      'transaction': doc.transaction,
                      'transactionType': doc.transactionType,
                      'amount': doc.amount,
                      'lastUpdate': doc.lastUpdate,
                    };

                    return TransactionLog(transactionDetails);
                  }).toList(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RefreshIndicator(
          child: _pageContent(model),
          onRefresh: () async {
            await model.fetchWallet();
            await model.fetchWalletTransactions();
          },
        );
      },
    );
  }
}
