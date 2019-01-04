import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/tabs/options_fab.dart';
import 'package:flutter/material.dart';

import 'package:bank_app/pages/home_page.dart';
import 'package:bank_app/pages/wallet_page.dart';
import 'package:scoped_model/scoped_model.dart';

class TabsPage extends StatefulWidget {
  final MainModel _model;

  TabsPage(this._model);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    widget._model.fetchWallet();
    widget._model.fetchOffers();
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              HomePage(model),
              WalletPage(widget._model),
            ],
          ),
          floatingActionButton: OptionsFAB(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            // notchMargin: 10.0,
            child: Material(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.home,
                      size: 30.0,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.account_balance_wallet,
                      size: 30.0,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.settings,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Material(
//           color: Theme.of(context).primaryColor,
//           child: TabBar(
//             tabs: <Widget>[
//               Tab(
//                 icon: Icon(
//                   Icons.home,
//                   size: 30.0,
//                 ),
//               ),
//               Tab(
//                 icon: Icon(
//                   Icons.account_balance_wallet,
//                   size: 30.0,
//                 ),
//               ),
//               Tab(
//                 icon: Icon(
//                   Icons.person,
//                   size: 30.0,
//                 ),
//               ),
//             ],
//           ),
//         ),
