import 'package:flutter/material.dart';

import 'package:bank_app/pages/home_page.dart';
import 'package:bank_app/pages/wallet_page.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              HomePage(),
              WalletPage(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/loan-order');
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            // notchMargin: 10.0,
            child: Material(
              color: Theme.of(context).primaryColor,
              child: TabBar(
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
                  //  Tab(
                  //   icon: Icon(
                  //     Icons.update,
                  //     size: 30.0,
                  //   ),
                  // ),
                  Tab(
                    icon: Icon(
                      Icons.settings,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          )),
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
