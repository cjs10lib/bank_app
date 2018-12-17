import 'package:flutter/material.dart';

import 'package:bank_app/pages/home_page.dart';
import 'package:bank_app/pages/wallet_page.dart';

class TabsPage extends StatefulWidget {

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with SingleTickerProviderStateMixin {
  TabController _tabController;  

  @override
    void initState() {
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
    return Scaffold(
        body: TabBarView(
          controller: _tabController,
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
        ));
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
