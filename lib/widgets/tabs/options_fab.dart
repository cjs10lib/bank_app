import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';

class OptionsFAB extends StatefulWidget {
  @override
  _OptionsFABState createState() => _OptionsFABState();
}

class _OptionsFABState extends State<OptionsFAB> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    super.initState();
  }

  void _navigateToLoan() {
    Navigator.of(context).pushNamed('/loan');
  }

  void _navigateToTransfer() {
    Navigator.of(context).pushNamed('/transfer');
  }

  void _navigateToDeposit() {
    Navigator.of(context).pushNamed('/deposit');
  }

  void _navigateToWithdrawal() {
    Navigator.of(context).pushNamed('/withdrawal');
  }

  @override
  Widget build(BuildContext context) {
    var _fabMiniMenuItemList = [
      FabMiniMenuItem.withText(
          Icon(Icons.account_balance),
          Theme.of(context).primaryColor,
          2.0,
          'Loan',
          _navigateToLoan,
          'Loan',
          Theme.of(context).primaryColor,
          Colors.white,
          true),
      FabMiniMenuItem.withText(
          Icon(Icons.compare_arrows),
          Theme.of(context).primaryColor,
          2.0,
          'Transfer',
          _navigateToTransfer,
          'Transfer',
          Theme.of(context).primaryColor,
          Colors.white,
          true),
      FabMiniMenuItem.withText(
          Icon(Icons.account_balance_wallet),
          Theme.of(context).primaryColor,
          2.0,
          'Deposit',
          _navigateToDeposit,
          'Deposit',
          Theme.of(context).primaryColor,
          Colors.white,
          true),
      FabMiniMenuItem.withText(
          Icon(Icons.move_to_inbox),
          Theme.of(context).primaryColor,
          2.0,
          'Withdrawal',
          _navigateToWithdrawal,
          'Withdrawal',
          Theme.of(context).primaryColor,
          Colors.white,
          true),
    ];

    return FabDialer(_fabMiniMenuItemList, Theme.of(context).primaryColor, new Icon(Icons.add));
  }
}

// Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           height: 55.0,
//           width: 55.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//                 parent: _controller,
//                 curve: Interval(0.75, 1.0, curve: Curves.easeOut)),
//             child: FloatingActionButton(
//                 mini: true,
//                 heroTag: 'loan',
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: Icon(Icons.account_balance),
//                 tooltip: 'Loan',
//                 onPressed: () =>
//                     Navigator.of(context).pushNamed('/loan')),
//           ),
//         ),
//         Container(
//           height: 55.0,
//           width: 55.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//                 parent: _controller,
//                 curve: Interval(0.5, 0.75, curve: Curves.easeOut)),
//             child: FloatingActionButton(
//                 mini: true,
//                 heroTag: 'transfer',
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: Icon(Icons.compare_arrows),
//                 tooltip: 'Transfer',
//                 onPressed: () =>
//                     Navigator.of(context).pushNamed('/transfer')),
//           ),
//         ),
//         Container(
//           height: 55.0,
//           width: 55.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//                 parent: _controller,
//                 curve: Interval(0.25, 0.5, curve: Curves.easeOut)),
//             child: FloatingActionButton(
//                 mini: true,
//                 heroTag: 'deposit',
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: Icon(Icons.account_balance_wallet),
//                 tooltip: 'Deposit',
//                 onPressed: () =>
//                     Navigator.of(context).pushNamed('/deposit')),
//           ),
//         ),
//         Container(
//           height: 55.0,
//           width: 55.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//                 parent: _controller,
//                 curve: Interval(0.0, 0.25, curve: Curves.easeOut)),
//             child: FloatingActionButton(
//                 mini: true,
//                 heroTag: 'withdrawal',
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: Icon(Icons.move_to_inbox),
//                 tooltip: 'Withdrawal',
//                 onPressed: () =>
//                     Navigator.of(context).pushNamed('/withdrawal')),
//           ),
//         ),
//         FloatingActionButton(
//             heroTag: 'options',
//             tooltip: 'Transaction Options',
//             backgroundColor: Theme.of(context).primaryColor,
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (BuildContext context, Widget child) {
//                 return Transform(
//                   alignment: FractionalOffset.center,
//                   transform: Matrix4.rotationZ(_controller.value * 0.25 * math.pi),
//                   child: Icon(Icons.add));
//               },
//             ),
//             onPressed: () {
//               if (_controller.isDismissed) {
//                 _controller.forward();
//               } else {
//                 _controller.reverse();
//               }
//             }),
//       ],
//     );
